import '../../../../domain/enums.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  final TrendingRepository trendingRepository;

  Future<void> init() async {
    await loadMoviesAndSeries();
    await loadPerformers();
  }

  Future<void> onTimeWindowChanged(TimeWindow timeWindow) async {
    if (state.moviesAndSeries.timeWindow != timeWindow) {
      state = state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.loading(timeWindow),
      );
      await loadMoviesAndSeries();
    }
  }

  Future<void> loadMoviesAndSeries({
    MoviesAndSeriesState? moviesAndSeries,
  }) async {
    if (moviesAndSeries != null) {
      state = state.copyWith(
        moviesAndSeries: moviesAndSeries,
      );
    }
    final result = await trendingRepository.getMoviesAndSeries(
      state.moviesAndSeries.timeWindow,
    );
    state = result.when(
      left: (_) => state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.failed(
          state.moviesAndSeries.timeWindow,
        ),
      ),
      right: (list) => state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.loaded(
          list: list,
          timeWindow: state.moviesAndSeries.timeWindow,
        ),
      ),
    );
  }

  Future<void> loadPerformers({
    PerformersState? performers,
  }) async {
    if (performers != null) {
      state = state.copyWith(
        performers: performers,
      );
    }
    final result = await trendingRepository.getPerformers();
    state = result.when(
      left: (_) => state.copyWith(
        performers: const PerformersState.failed(),
      ),
      right: (list) => state.copyWith(
        performers: PerformersState.loaded(list),
      ),
    );
  }
}
