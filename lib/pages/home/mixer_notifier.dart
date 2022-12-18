import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:win32audio/win32audio.dart';
import 'package:win_speaker_switcher/models/home/mixer.dart';

import '../../models/audio_extended.dart';
import '../../services/home_service.dart';
import 'icons_notifier.dart';

class MixerNotifier extends StateNotifier<AsyncValue<Mixer>> {
  final Ref ref;

  late final IconsNotifier iconsNotifier;

  late final HomeService service;

  MixerNotifier(this.ref) : super(const AsyncValue.loading()) {
    service = ref.watch(homeService);
    iconsNotifier = ref.watch(iconsNotifierProvider.notifier);
  }

  Future<void> setData(Mixer data) async {
    if (!mounted) return;
    if (!state.hasValue) {
      state = AsyncValue<Mixer>.data(data);
    } else {
      state = AsyncValue<Mixer>.data(state.value!.copyWith(
          mixerList: data.mixerList,
          stateFetchAudioMixerPeak: data.stateFetchAudioMixerPeak));
    }
  }

  Future<void> audioMixersUpdate() async {
    if (!mounted) return;
    if (state.hasValue) {
      var mixerList = await AudioExtended.enumAudioMixer() ?? [];

      if (!const DeepCollectionEquality()
          .equals(state.value!.mixerList, mixerList)) {
        await iconsNotifier.updateProcessIcons(mixerList);
      }

      state =
          AsyncValue<Mixer>.data(state.value!.copyWith(mixerList: mixerList));
    }
  }

  Future<void> onChangedProcessSlider(double volume, int index) async {
    if (!mounted) return;

    if (state.hasValue) {
      await Audio.setAudioMixerVolume(
          state.value!.mixerList[index].processId, volume);
      state.value!.mixerList[index].maxVolume = volume;
      state = AsyncValue<Mixer>.data(
          state.value!.copyWith(mixerList: state.value!.mixerList));
    }
  }

  Future<void> onChangedContinuouslyFetchCheckbox(bool? actualState) async {
    if (!mounted) return;

    if (state.hasValue) {
      var stateFetchAudioMixerPeak = actualState!;
      state = AsyncValue<Mixer>.data(state.value!
          .copyWith(stateFetchAudioMixerPeak: stateFetchAudioMixerPeak));
    }
  }

  bool get stateFetchAudioMixerPeak {
    if (state.hasValue) {
      return state.value!.stateFetchAudioMixerPeak;
    } else {
      return false;
    }
  }
}

final mixerNotifierProvider =
    StateNotifierProvider<MixerNotifier, AsyncValue<Mixer>>(
        (ref) => MixerNotifier(ref));
