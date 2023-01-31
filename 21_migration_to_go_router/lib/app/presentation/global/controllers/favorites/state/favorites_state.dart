import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/media/media.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  factory FavoritesState.loading() = FavoritesStateLoading;
  factory FavoritesState.failed() = FavoritesStateFailed;
  factory FavoritesState.loaded({
    required Map<int, Media> movies,
    required Map<int, Media> series,
  }) = FavoritesStateLoaded;
}
