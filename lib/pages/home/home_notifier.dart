import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:win32audio/win32audio.dart';
import '../../models/audio_device_extended/audio_device_extended.dart';
import '../../models/audio_extended.dart';
import '../../models/home/home.dart';
import '../../services/home_service.dart';

class HomeNotifier extends StateNotifier<AsyncValue<Home>> {
  final Ref ref;

  late final HomeService service;

  HomeNotifier(this.ref) : super(const AsyncValue.loading()) {
    service = ref.watch(homeService);
  }

  Future<void> getData() async {
    state = AsyncValue<Home>.data(await service.getData());
  }

  Future<void> fetchAudioDevices() async {
    if (!mounted) return;
    if (state.hasValue) {
      var audioDevices = await AudioExtended.enumDevices(
          state.value!.audioDeviceType, state.value!.audioDevices) ??
          [];
      var volume = await Audio.getVolume(state.value!.audioDeviceType);
      var defaultDevice =
      (await AudioExtended.getDefaultDevice(state.value!.audioDeviceType))!;

      Map<String, List<int>> audioIcons = {};
      for (var audioDevice in audioDevices) {
        if (audioIcons[audioDevice.id] == null) {
          audioIcons[audioDevice.id] = (await WinIcons()
              .extractFileIcon(audioDevice.iconPath,
              iconID: audioDevice.iconID)) as List<int>;
        }
      }

      var mixerList = await AudioExtended.enumAudioMixer() ?? [];
      for (var mixer in mixerList) {
        if (audioIcons[mixer.processPath] == null) {
          audioIcons[mixer.processPath] =
          (await WinIcons().extractFileIcon(mixer.processPath))!.toList();
        }
      }

      var fetchStatus = "Get";

      state = AsyncValue<Home>.data(state.value!.copyWith(
          audioDevices: audioDevices,
          volume: volume,
          defaultDevice: defaultDevice,
          mixerList: mixerList,
          fetchStatus: fetchStatus,
          audioIcons: audioIcons));
    }
  }

  Future<void> _keyDownHandler(HotKey hotKey) async {
    if (!mounted) return;

    if (state.hasValue) {
      if (!state.value!.audioDevices
          .firstWhere((element) => element.hotKey == hotKey)
          .isActive) {
        await Audio.setDefaultDevice(state.value!.audioDevices
            .firstWhere((element) => element.hotKey == hotKey)
            .id);
        fetchAudioDevices();
      }
    }
  }

  Future<void> handleHotKeyRegister(HotKey hotKey, int index) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: _keyDownHandler,
    );
  }

  Future<void> handleHotKeyUnregister(HotKey hotKey) async {
    await hotKeyManager.unregister(hotKey);
  }

  Future<void> audioMixersUpdate() async {
    if (!mounted) return;
    if (state.hasValue) {
      if (state.value!.stateFetchAudioMixerPeak) {
        var mixerList = await AudioExtended.enumAudioMixer() ?? [];

        for (var mixer in state.value!.mixerList) {
          if (state.value!.audioIcons[mixer.processPath] == null) {
            state.value!.audioIcons[mixer.processPath] = (await WinIcons()
                .extractFileIcon(mixer.processPath)) as List<int>;
          }
        }
        state = AsyncValue<Home>.data(state.value!.copyWith(
            mixerList: mixerList));
      }
    }
  }

  Future<void> onPressGetButton() async {
    if (!mounted) return;
    if (state.hasValue) {
      var fetchStatus = "Getting...";
      state = AsyncValue<Home>.data(state.value!.copyWith(
          fetchStatus: fetchStatus));
      await fetchAudioDevices();
    }
  }

  Future<void> init() async {
    if (!mounted) return;

    if (!state.hasValue) {
      if (state.isLoading) {
        state = AsyncValue<Home>.data(await service.getData());
      }
      if (!state.value!.initialized) {
        await service.localStorage.ready;
        var tmpAudioDevices = service.localStorage.getItem("audioDevices") ??
            [];

        var audioDevices = List<AudioDeviceExtended>.from(
            (tmpAudioDevices as List)
                .map((item) => AudioDeviceExtended.fromJson(item)));
        state =
        AsyncValue<Home>.data(state.value!.copyWith(audioDevices: audioDevices));

        fetchAudioDevices();

        var initialized = true;

        state = AsyncValue<Home>.data(state.value!.copyWith(initialized: initialized));
      }

      for (var element in state.value!.audioDevices) {
        if (element.hotKey != null) {
          handleHotKeyRegister(
              element.hotKey!, state.value!.audioDevices.indexOf(element));
        }
      }
    }
  }

  Future<void> onChangedSlider(double volume) async {
    if (!mounted) return;

    if (state.hasValue) {
      await Audio.setVolume(volume, state.value!.audioDeviceType);
      state = AsyncValue<Home>.data(state.value!.copyWith(volume: volume));
    }
  }

  Future<void> onSecondaryTapShortcutButton(int index) async {
    if (!mounted) return;
    if (state.hasValue && state.value!.audioDevices[index].hotKey != null) {
      handleHotKeyUnregister(state.value!.audioDevices[index].hotKey!);

      state.value!.audioDevices[index].hotKey = null;

      state = AsyncValue<Home>.data(state.value!.copyWith(
          audioDevices: state.value!.audioDevices));

      await service.localStorage.setItem("audioDevices",
          state.value!.audioDevices.map((element) => element.toMap()).toList());
    }
  }

  Future<void> onHotKeyRecorded(HotKey newHotKey, int index) async {
    if (!mounted) return;

    if (state.hasValue) {
      if (state.value!.audioDevices[index].hotKey != null) {
        handleHotKeyUnregister(state.value!.audioDevices[index].hotKey!);
      }
      handleHotKeyRegister(newHotKey, index);

      state.value!.audioDevices[index].hotKey = newHotKey;
      state = AsyncValue<Home>.data(state.value!.copyWith(
          audioDevices: state.value!.audioDevices));

      await service.localStorage.setItem("audioDevices",
          state.value!.audioDevices.map((element) => element.toMap()).toList());
    }
  }

  Future<void> setDefaultDevice(int index) async {
    if (!mounted) return;

    if (state.hasValue) {
      await Audio.setDefaultDevice(
          state.value!.audioDevices[index].id);
      fetchAudioDevices();
      state = AsyncValue<Home>.data(state.value!.copyWith(
          defaultDevice: state.value!.audioDevices[index]));
    }
  }

  Future<void> onChangedContinuouslyFetchCheckbox(bool? actualState) async {
    if (!mounted) return;

    if (state.hasValue) {
      var stateFetchAudioMixerPeak = actualState!;
      state = AsyncValue<Home>.data(state.value!.copyWith(
          stateFetchAudioMixerPeak: stateFetchAudioMixerPeak));
    }
  }

  Future<void> onChangedProcessSlider(double volume, int index) async {
    if (!mounted) return;

    if (state.hasValue) {
      await Audio.setAudioMixerVolume(
          state.value!.mixerList[index].processId,
          volume);
      state.value!.mixerList[index].maxVolume = volume;
      state = AsyncValue<Home>.data(state.value!.copyWith(
          mixerList: state.value!.mixerList));
    }
  }

  Uint8List getIcon(String index) {
    if (!mounted) return Uint8List(0);
    if (state.hasValue) {
      return Uint8List.fromList(state.value!.audioIcons[index]!);
    }
    return Uint8List(0);
  }
}

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, AsyncValue<Home>>((ref) {
  return HomeNotifier(ref);
});
