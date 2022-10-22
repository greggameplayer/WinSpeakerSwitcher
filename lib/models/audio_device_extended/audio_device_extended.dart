import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:win32audio/win32audio.dart';

part 'audio_device_extended.g.dart';

@JsonSerializable()
class AudioDeviceExtended extends AudioDevice {
  HotKey? hotKey;

  AudioDeviceExtended({
    String? id,
    String? name,
    String? iconPath,
    int? iconID,
    bool? isActive,
  }) {
    if (id != null) {
      this.id = id;
    }

    if (name != null) {
      this.name = name;
    }

    if (iconPath != null) {
      this.iconPath = iconPath;
    }

    if (iconID != null) {
      this.iconID = iconID;
    }

    if (isActive != null) {
      this.isActive = isActive;
    }
  }

  @override
  String toString() {
    return 'AudioDeviceExtended{id: $id, name: $name, iconPath: $iconPath, iconID: $iconID, isActive: $isActive, hotKey: $hotKey}';
  }

  //tomap
  @override
  Map<String, dynamic> toMap() {
    if (hotKey != null) {
      return {
        'id': id,
        'name': name,
        'iconPath': iconPath,
        'iconID': iconID,
        'isActive': isActive,
        'hotKey': hotKey!.toJson(),
      };
    } else {
      return {
        'id': id,
        'name': name,
        'iconPath': iconPath,
        'iconID': iconID,
        'isActive': isActive,
      };
    }
  }

  factory AudioDeviceExtended.fromJson(Map<String, dynamic> json) => _$AudioDeviceExtendedFromJson(json);

  Map<String, dynamic> toJson() => _$AudioDeviceExtendedToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AudioDeviceExtended &&
        other.id == id &&
        other.name == name &&
        other.iconPath == iconPath &&
        other.iconID == iconID &&
        other.isActive == isActive &&
        other.hotKey == hotKey;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        iconPath.hashCode ^
        iconID.hashCode ^
        isActive.hashCode ^
        hotKey.hashCode;
  }
}
