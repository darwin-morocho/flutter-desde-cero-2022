import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/genre/genre.dart';
import 'package:tv/app/domain/models/movie/movie.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';
import 'package:tv/app/inject_repositories.dart';

import '../../../../../../mocks.mocks.dart';

void mockMovieViewFailed() {
  when(
    (Repositories.movies as MockMoviesRepository).getMovieById(any),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Left(
        HttpRequestFailure.notFound(),
      );
    },
  );
}

void mockMovieViewSuccess() {
  when(
    (Repositories.movies as MockMoviesRepository).getMovieById(any),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Right(
        Movie(
          id: 123,
          genres: [
            Genre(id: 1, name: ' name'),
          ],
          overview: 'overview',
          runtime: 200,
          posterPath: '/posterPath.jpg',
          releaseDate: DateTime.now(),
          voteAverage: 8,
          title: 'title',
          originalTitle: 'originalTitle',
          backdropPath: '/backdropPath.jpg',
        ),
      );
    },
  );

  int retry = 0;
  when(
    (Repositories.movies as MockMoviesRepository).getCastByMovie(any),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      if (retry == 0) {
        retry++;
        return Left(
          HttpRequestFailure.network(),
        );
      }

      return Right(
        [
          Performer(
            id: 123,
            name: 'name',
            popularity: 9,
            originalName: 'originalName',
            profilePath: '/profilePath.jpg',
            knownFor: [],
          ),
          Performer(
            id: 126,
            name: 'name',
            popularity: 9,
            originalName: 'originalName',
            profilePath: '/profilePath.jpg',
            knownFor: [],
          ),
        ],
      );
    },
  );

  when(
    (Repositories.account as MockAccountRepository).getFavorites(any),
  ).thenAnswer(
    (_) async => Right(
      {},
    ),
  );

  when(
    (Repositories.account as MockAccountRepository).markAsFavorite(
      mediaId: anyNamed('mediaId'),
      type: anyNamed('type'),
      favorite: anyNamed('favorite'),
    ),
  ).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(milliseconds: 50),
      );
      return Right(null);
    },
  );
}
