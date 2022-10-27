import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:win32audio/win32audio.dart';
import 'package:win_speaker_switcher/models/home/home.dart';

import '../models/audio_device_extended/audio_device_extended.dart';

final homeService = Provider((ref) => HomeService());

class HomeService {
  Home homeState = Home(defaultDevice: AudioDeviceExtended(), initialized: false, audioDeviceType: AudioDeviceType.output, audioDevices: [], mixerList: [], stateFetchAudioMixerPeak: false, volume: 0.0, fetchStatus: "Get");

  LocalStorage localStorage = LocalStorage('win_speaker_switcher');

  Future<Home> getData() async {
    return homeState;
  }

  Future<void> setData(Home data) async {
    homeState = data;
  }
}
