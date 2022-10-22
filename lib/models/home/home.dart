import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:win32audio/win32audio.dart';
import 'package:win_speaker_switcher/models/process_volume_extended/process_volume_extended.dart';

import '../audio_device_extended/audio_device_extended.dart';

part 'home.g.dart';
part 'home.freezed.dart';

@freezed
class Home with _$Home {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Home({
    required AudioDeviceExtended defaultDevice,
    required bool initialized,
    required AudioDeviceType audioDeviceType,
    required List<AudioDeviceExtended> audioDevices,
    required List<ProcessVolumeExtended> mixerList,
    required bool stateFetchAudioMixerPeak,
    required double volume,
    required String fetchStatus,
    required Map<String, List<int>> audioIcons
}) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}
