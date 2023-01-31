import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:tv/app/presentation/global/controllers/favorites/state/favorites_state.dart';

import '../../../mocks.mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  late FavoritesController controller;
  late MockAccountRepository repository;
  setUp(
    () {
      repository = MockAccountRepository();
      controller = FavoritesController(
        FavoritesState.loading(),
        accountRepository: repository,
      );
    },
  );

  test(
    'FavoritesController > init > failed',
    () async {
      when(repository.getFavorites(any)).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      expect(
        controller.state,
        isA<FavoritesStateLoading>(),
      );
      await controller.init();
      expect(
        controller.state,
        isA<FavoritesStateFailed>(),
      );
    },
  );

  test(
    'FavoritesController > init > failed > series',
    () async {
      when(repository.getFavorites(MediaType.movie)).thenAnswer(
        (_) async => Right({}),
      );
      when(repository.getFavorites(MediaType.tv)).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      expect(
        controller.state,
        isA<FavoritesStateLoading>(),
      );
      await controller.init();
      expect(
        controller.state,
        isA<FavoritesStateFailed>(),
      );
    },
  );

  test(
    'FavoritesController > init > success',
    () async {
      when(repository.getFavorites(any)).thenAnswer(
        (_) async => Right(
          {},
        ),
      );
      when(
        repository.markAsFavorite(
          mediaId: anyNamed('mediaId'),
          type: anyNamed('type'),
          favorite: anyNamed('favorite'),
        ),
      ).thenAnswer(
        (_) async => Right(null),
      );
      expect(
        controller.state,
        isA<FavoritesStateLoading>(),
      );
      await controller.init();
      expect(
        controller.state,
        isA<FavoritesStateLoaded>(),
      );

      await controller.markAsFavorite(mockMovieMedia);
      await controller.markAsFavorite(mockSerieMedia);

      controller.state.maybeMap(
        loaded: (state) {
          expect(
            state.movies.keys.contains(1),
            true,
          );
          expect(
            state.series.keys.contains(2),
            true,
          );
        },
        orElse: () => throw Exception('invalid state'),
      );

      await controller.markAsFavorite(mockMovieMedia);
      await controller.markAsFavorite(mockSerieMedia);

      controller.state.maybeMap(
        loaded: (state) {
          expect(
            state.movies.keys.contains(1),
            false,
          );
          expect(
            state.series.keys.contains(2),
            false,
          );
        },
        orElse: () => throw Exception('invalid state'),
      );
    },
  );
}
