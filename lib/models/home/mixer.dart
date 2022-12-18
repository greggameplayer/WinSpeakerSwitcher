import 'package:freezed_annotation/freezed_annotation.dart';

import '../process_volume_extended/process_volume_extended.dart';

part 'mixer.g.dart';
part 'mixer.freezed.dart';

@freezed
class Mixer with _$Mixer {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Mixer({
    required List<ProcessVolumeExtended> mixerList,
    required bool stateFetchAudioMixerPeak,
  }) = _Mixer;

  factory Mixer.fromJson(Map<String, dynamic> json) => _$MixerFromJson(json);
}
