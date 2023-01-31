import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/movie/movie.dart';
import 'package:tv/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:tv/app/presentation/modules/movie/controller/state/movie_state.dart';

import '../../../../../mocks.mocks.dart';

void main() {
  late MovieController controller;
  late MockMoviesRepository repository;
  setUp(
    () {
      repository = MockMoviesRepository();
      controller = MovieController(
        MovieState.loading(),
        movieId: 123,
        moviesRepository: repository,
      );
    },
  );
  test(
    'MovieController > init > failed',
    () async {
      when(repository.getMovieById(any)).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      expect(controller.state, isA<MovieStateLoading>());
      await controller.init();
      expect(controller.state, isA<MovieStateFailed>());
    },
  );

  test(
    'MovieController > init > success',
    () async {
      when(repository.getMovieById(any)).thenAnswer(
        (_) async => Right(
          Movie(
            id: 123,
            genres: [],
            overview: 'overview',
            runtime: 200,
            posterPath: '/posterPath.jpg',
            releaseDate: DateTime.now(),
            voteAverage: 8,
            title: 'title',
            originalTitle: 'originalTitle',
            backdropPath: '/backdropPath.jpg',
          ),
        ),
      );

      await controller.init();
      expect(controller.state, isA<MovieStateLoaded>());
    },
  );
}
