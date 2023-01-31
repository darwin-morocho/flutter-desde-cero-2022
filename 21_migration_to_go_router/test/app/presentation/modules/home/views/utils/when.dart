import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';
import 'package:tv/app/inject_repositories.dart';

import '../../../../../../mocks.mocks.dart';

void homeViewMockFail() {
  when(Repositories.connectivity.hasInternet).thenReturn(false);
  when(Repositories.connectivity.onInternetChanged).thenAnswer(
    (_) => const Stream.empty(),
  );

  when(
    (Repositories.trending as MockTrendingRepository).getMoviesAndSeries(any),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Left(
        HttpRequestFailure.network(),
      );
    },
  );
  when(Repositories.trending.getPerformers()).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Left(
        HttpRequestFailure.network(),
      );
    },
  );
}

void homeViewMockSuccess() {
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
    Media(
      id: 124,
      overview: 'overview',
      title: 'title',
      originalTitle: 'originalTitle',
      posterPath: 'posterPath',
      backdropPath: 'backdropPath',
      voteAverage: 8,
      type: MediaType.movie,
    ),
  ];

  when(Repositories.connectivity.hasInternet).thenReturn(true);
  when(Repositories.connectivity.onInternetChanged).thenAnswer(
    (_) => const Stream.empty(),
  );

  when(
    (Repositories.trending as MockTrendingRepository).getMoviesAndSeries(any),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Right(mediaList);
    },
  );
  when(Repositories.trending.getPerformers()).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Right(
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
      );
    },
  );
}
