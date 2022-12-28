import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/movie/movie.dart';
import '../models/peformer/performer.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id);
  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(
    int movieId,
  );
}
