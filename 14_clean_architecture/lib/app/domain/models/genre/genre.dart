import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'genre.freezed.dart';
part 'genre.g.dart';

@freezed
class Genre with _$Genre {
  factory Genre({
    required int id,
    required String name,
  }) = _Genre;

  factory Genre.fromJson(Json json) => _$GenreFromJson(json);
}
