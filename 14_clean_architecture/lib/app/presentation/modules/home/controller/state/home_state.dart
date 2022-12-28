import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/peformer/performer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(
      MoviesAndSeriesState.loading(TimeWindow.day),
    )
        MoviesAndSeriesState moviesAndSeries,

    ///
    @Default(
      PerformersState.loading(),
    )
        PerformersState performers,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required TimeWindow timeWindow,
    required List<Media> list,
  }) = MoviesAndSeriesStateLoaded;
}

@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading() = PerformersStateLoading;
  const factory PerformersState.failed() = PerformersStateFailed;
  const factory PerformersState.loaded(
    List<Performer> list,
  ) = PerformersStateLoaded;
}
