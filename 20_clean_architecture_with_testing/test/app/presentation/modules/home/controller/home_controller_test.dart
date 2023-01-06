import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/enums.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';
import 'package:tv/app/presentation/modules/home/controller/home_controller.dart';
import 'package:tv/app/presentation/modules/home/controller/state/home_state.dart';

import '../../../../../mocks.mocks.dart';

void main() {
  late HomeController controller;
  late MockTrendingRepository trendingRepository;
  setUp(
    () {
      trendingRepository = MockTrendingRepository();
      controller = HomeController(
        HomeState(),
        trendingRepository: trendingRepository,
      );
    },
  );
  test(
    'HomeController > load > fail',
    () async {
      when(trendingRepository.getMoviesAndSeries(any)).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      when(trendingRepository.getPerformers()).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      await controller.init();
      expect(
        controller.state.moviesAndSeries,
        isA<MoviesAndSeriesStateFailed>(),
      );
      expect(
        controller.state.performers,
        isA<PerformersStateFailed>(),
      );
      await controller.loadMoviesAndSeries(
        moviesAndSeries: MoviesAndSeriesState.loading(
          controller.state.moviesAndSeries.timeWindow,
        ),
      );

      expect(
        controller.oldState.moviesAndSeries,
        isA<MoviesAndSeriesStateLoading>(),
      );

      await controller.loadPerformers(
        performers: const PerformersState.loading(),
      );
      expect(
        controller.oldState.performers,
        isA<PerformersStateLoading>(),
      );
    },
  );

  test(
    'HomeController > load > success',
    () async {
      final mediaList = [
        Media(
          id: 123,
          overview: 'overview',
          title: 'title',
          originalTitle: 'originalTitle',
          posterPath: 'posterPath',
          backdropPath: 'backdropPath',
          voteAverage: 8,
          type: MediaType.movie,
        ),
      ];

      when(trendingRepository.getMoviesAndSeries(any)).thenAnswer(
        (_) async => Right(mediaList),
      );
      when(trendingRepository.getPerformers()).thenAnswer(
        (_) async => Right(
          [
            Performer(
              id: 12,
              name: 'name',
              popularity: 9,
              originalName: 'originalName',
              profilePath: 'profilePath',
              knownFor: mediaList,
            ),
          ],
        ),
      );
      await controller.init();
      expect(
        controller.state.moviesAndSeries,
        isA<MoviesAndSeriesStateLoaded>(),
      );
      expect(
        controller.state.performers,
        isA<PerformersStateLoaded>(),
      );

      await controller.onTimeWindowChanged(TimeWindow.week);
      expect(
        controller.oldState.moviesAndSeries,
        isA<MoviesAndSeriesStateLoading>(),
      );
      expect(
        controller.state.moviesAndSeries,
        isA<MoviesAndSeriesStateLoaded>(),
      );
    },
  );
}
