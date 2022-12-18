// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mixer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Mixer _$$_MixerFromJson(Map<String, dynamic> json) => _$_Mixer(
      mixerList: (json['mixer_list'] as List<dynamic>)
          .map((e) => ProcessVolumeExtended.fromJson(e as Map<String, dynamic>))
          .toList(),
      stateFetchAudioMixerPeak: json['state_fetch_audio_mixer_peak'] as bool,
    );

Map<String, dynamic> _$$_MixerToJson(_$_Mixer instance) => <String, dynamic>{
      'mixer_list': instance.mixerList,
      'state_fetch_audio_mixer_peak': instance.stateFetchAudioMixerPeak,
    };
