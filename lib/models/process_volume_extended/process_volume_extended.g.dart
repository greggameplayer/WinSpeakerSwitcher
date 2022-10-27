// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_volume_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessVolumeExtended _$ProcessVolumeExtendedFromJson(
        Map<String, dynamic> json) =>
    ProcessVolumeExtended(
      processId: json['processId'] as int?,
      processPath: json['processPath'] as String?,
      maxVolume: (json['maxVolume'] as num?)?.toDouble(),
      peakVolume: (json['peakVolume'] as num?)?.toDouble(),
    )..processName = json['processName'] as String?;

Map<String, dynamic> _$ProcessVolumeExtendedToJson(
        ProcessVolumeExtended instance) =>
    <String, dynamic>{
      'processId': instance.processId,
      'processPath': instance.processPath,
      'maxVolume': instance.maxVolume,
      'peakVolume': instance.peakVolume,
      'processName': instance.processName,
    };
