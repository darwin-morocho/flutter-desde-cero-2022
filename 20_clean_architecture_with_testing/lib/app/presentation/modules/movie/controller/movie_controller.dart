import '../../../../domain/repositories/movies_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(
    super.state, {
    required this.movieId,
    required this.moviesRepository,
  });

  final int movieId;
  final MoviesRepository moviesRepository;

  Future<void> init() async {
    state =  MovieState.loading();
    
    final result = await moviesRepository.getMovieById(movieId);
    state = result.when(
      left: (_) => MovieState.failed(),
      right: (movie) => MovieState.loaded(movie),
    );
  }
}
