import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';
import '../media/media.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@Freezed(toJson: false)
class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,

    ///
    @JsonKey(name: 'original_name')
        required String originalName,
    @JsonKey(name: 'profile_path')
        required String profilePath,
    @JsonKey(
      name: 'known_for',
      fromJson: getMediaList,
    )
        required List<Media> knownFor,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}
