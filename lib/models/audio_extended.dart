import 'package:win32audio/win32audio.dart';

import 'audio_device_extended.dart';

class AudioExtended extends Audio {
  static Future<List<AudioDeviceExtended>?> enumDevices(AudioDeviceType audioDeviceType, List<AudioDeviceExtended> currentAudioDevices, {AudioRole audioRole = AudioRole.multimedia}) async {
    final Map<String, dynamic> arguments = {'deviceType': audioDeviceType.index, "role": audioRole.index};
    final Map<dynamic, dynamic> map = await audioMethodChannel.invokeMethod('enumAudioDevices', arguments);
    List<AudioDeviceExtended>? audioDevices = [];
    for (var key in map.keys) {
      final audioDevice = AudioDeviceExtended();
      audioDevice.id = map[key]['id'];
      audioDevice.name = map[key]['name'];
      final iconData = map[key]['iconInfo'].split(",");
      audioDevice.iconPath = iconData[0];
      audioDevice.iconID = int.parse(iconData[1]);
      audioDevice.isActive = map[key]['isActive'];
      audioDevices.add(audioDevice);
    }

    List<AudioDeviceExtended> modifiedAudioDevices = [];

    for (var audioDevice in audioDevices) {
      bool isModified = false;
      for (AudioDeviceExtended currentAudioDevice in currentAudioDevices) {
        if (audioDevice.id == currentAudioDevice.id && audioDevice.name == currentAudioDevice.name && audioDevice.iconPath == currentAudioDevice.iconPath && audioDevice.iconID == currentAudioDevice.iconID) {
          currentAudioDevice.isActive = audioDevice.isActive;
          modifiedAudioDevices.add(currentAudioDevice);
          isModified = true;
          break;
        }
      }

      if (!isModified) {
        modifiedAudioDevices.add(audioDevice);
      }
    }

    return modifiedAudioDevices;
  }

  static Future<AudioDeviceExtended?> getDefaultDevice(AudioDeviceType audioDeviceType, {AudioRole audioRole = AudioRole.multimedia}) async {
    final Map<String, dynamic> arguments = {'deviceType': audioDeviceType.index, "role": audioRole.index};
    final Map<dynamic, dynamic> map = await audioMethodChannel.invokeMethod('getDefaultDevice', arguments);
    final audioDevice = AudioDeviceExtended();
    audioDevice.id = map['id'];
    audioDevice.name = map['name'];
    final iconData = map['iconInfo'].split(",");
    audioDevice.iconPath = iconData[0];
    audioDevice.iconID = int.parse(iconData[1]);
    audioDevice.isActive = map['isActive'];
    return audioDevice;
  }
}
