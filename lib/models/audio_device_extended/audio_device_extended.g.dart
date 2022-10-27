// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_device_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioDeviceExtended _$AudioDeviceExtendedFromJson(Map<String, dynamic> json) =>
    AudioDeviceExtended(
      id: json['id'] as String?,
      name: json['name'] as String?,
      iconPath: json['iconPath'] as String?,
      iconID: json['iconID'] as int?,
      isActive: json['isActive'] as bool?,
    )..hotKey = json['hotKey'] == null
        ? null
        : HotKey.fromJson(json['hotKey'] as Map<String, dynamic>);

Map<String, dynamic> _$AudioDeviceExtendedToJson(
        AudioDeviceExtended instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconPath': instance.iconPath,
      'iconID': instance.iconID,
      'isActive': instance.isActive,
      'hotKey': instance.hotKey,
    };
