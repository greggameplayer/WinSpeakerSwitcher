// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Home _$$_HomeFromJson(Map<String, dynamic> json) => _$_Home(
      defaultDevice: AudioDeviceExtended.fromJson(
          json['default_device'] as Map<String, dynamic>),
      initialized: json['initialized'] as bool,
      audioDeviceType:
          $enumDecode(_$AudioDeviceTypeEnumMap, json['audio_device_type']),
      audioDevices: (json['audio_devices'] as List<dynamic>)
          .map((e) => AudioDeviceExtended.fromJson(e as Map<String, dynamic>))
          .toList(),
      volume: (json['volume'] as num).toDouble(),
      fetchStatus: json['fetch_status'] as String,
    );

Map<String, dynamic> _$$_HomeToJson(_$_Home instance) => <String, dynamic>{
      'default_device': instance.defaultDevice,
      'initialized': instance.initialized,
      'audio_device_type': _$AudioDeviceTypeEnumMap[instance.audioDeviceType]!,
      'audio_devices': instance.audioDevices,
      'volume': instance.volume,
      'fetch_status': instance.fetchStatus,
    };

const _$AudioDeviceTypeEnumMap = {
  AudioDeviceType.output: 'output',
  AudioDeviceType.input: 'input',
};
