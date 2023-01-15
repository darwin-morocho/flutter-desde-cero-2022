import 'package:tv/app/domain/models/media/media.dart';

final mockMovieMedia = Media(
  id: 1,
  overview: 'overview',
  title: 'title',
  originalTitle: 'originalTitle',
  posterPath: 'posterPath',
  backdropPath: 'backdropPath',
  voteAverage: 5,
  type: MediaType.movie,
);

final mockSerieMedia = Media(
  id: 2,
  overview: 'overview',
  title: 'title',
  originalTitle: 'originalTitle',
  posterPath: 'posterPath',
  backdropPath: 'backdropPath',
  voteAverage: 5,
  type: MediaType.tv,
);
