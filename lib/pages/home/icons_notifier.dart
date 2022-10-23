import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win32audio/win32audio.dart';

import '../../models/audio_device_extended/audio_device_extended.dart';
import '../../models/process_volume_extended/process_volume_extended.dart';

class IconsNotifier extends StateNotifier<AsyncValue<Map<String, List<int>>>> {
  final Ref ref;

  Map<String, List<int>> get icons => state.value ?? {};

  IconsNotifier(this.ref) : super(const AsyncValue<Map<String, List<int>>>.data({}));

  Future<void> updateIcons(List<AudioDeviceExtended> audioDevices, List<ProcessVolumeExtended> mixerList) async {
    if (!mounted) return;

    if (state.hasValue) {
      Map<String, List<int>> audioIcons = {};
      for (var audioDevice in audioDevices) {
        if (audioIcons[audioDevice.id] == null) {
          audioIcons[audioDevice.id] = (await WinIcons()
              .extractFileIcon(audioDevice.iconPath,
              iconID: audioDevice.iconID)) as List<int>;
        }
      }

      for (var mixer in mixerList) {
        if (audioIcons[mixer.processPath] == null) {
          audioIcons[mixer.processPath] =
              (await WinIcons().extractFileIcon(mixer.processPath))!.toList();
        }
      }

      if (!const DeepCollectionEquality().equals(audioIcons, state.value)) {
        state = AsyncValue<Map<String, List<int>>>.data(audioIcons);
      }
    }
  }

  Future<void> updateProcessIcons(List<ProcessVolumeExtended> mixerList) async {
    if (!mounted) return;

    if (state.hasValue) {
      Map<String, List<int>> audioIcons = {};

      for (var mixer in mixerList) {
        if (audioIcons[mixer.processPath] == null) {
          audioIcons[mixer.processPath] =
              (await WinIcons().extractFileIcon(mixer.processPath))!.toList();
        }
      }

      Map<String, List<int>> result = state.value!.map((key, value) {
        if (audioIcons[key] != null && audioIcons[key] != value) {
          return MapEntry(key, audioIcons[key]!);
        } else {
          return MapEntry(key, value);
        }
      });

      if (!const DeepCollectionEquality().equals(result, state.value)) {
        state = AsyncValue<Map<String, List<int>>>.data(result);
      }
    }
  }

  Uint8List getIcon(String index) {
    if (!mounted) return Uint8List(0);
    if (state.hasValue) {
      return Uint8List.fromList(state.value![index]!);
    }
    return Uint8List(0);
  }

}

final iconsNotifierProvider = StateNotifierProvider<IconsNotifier, AsyncValue<Map<String, List<int>>>>((ref) => IconsNotifier(ref));
