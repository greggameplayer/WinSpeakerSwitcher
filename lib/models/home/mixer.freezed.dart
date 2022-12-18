// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Mixer _$MixerFromJson(Map<String, dynamic> json) {
  return _Mixer.fromJson(json);
}

/// @nodoc
mixin _$Mixer {
  List<ProcessVolumeExtended> get mixerList =>
      throw _privateConstructorUsedError;
  bool get stateFetchAudioMixerPeak => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MixerCopyWith<Mixer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixerCopyWith<$Res> {
  factory $MixerCopyWith(Mixer value, $Res Function(Mixer) then) =
      _$MixerCopyWithImpl<$Res, Mixer>;
  @useResult
  $Res call(
      {List<ProcessVolumeExtended> mixerList, bool stateFetchAudioMixerPeak});
}

/// @nodoc
class _$MixerCopyWithImpl<$Res, $Val extends Mixer>
    implements $MixerCopyWith<$Res> {
  _$MixerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mixerList = null,
    Object? stateFetchAudioMixerPeak = null,
  }) {
    return _then(_value.copyWith(
      mixerList: null == mixerList
          ? _value.mixerList
          : mixerList // ignore: cast_nullable_to_non_nullable
              as List<ProcessVolumeExtended>,
      stateFetchAudioMixerPeak: null == stateFetchAudioMixerPeak
          ? _value.stateFetchAudioMixerPeak
          : stateFetchAudioMixerPeak // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MixerCopyWith<$Res> implements $MixerCopyWith<$Res> {
  factory _$$_MixerCopyWith(_$_Mixer value, $Res Function(_$_Mixer) then) =
      __$$_MixerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProcessVolumeExtended> mixerList, bool stateFetchAudioMixerPeak});
}

/// @nodoc
class __$$_MixerCopyWithImpl<$Res> extends _$MixerCopyWithImpl<$Res, _$_Mixer>
    implements _$$_MixerCopyWith<$Res> {
  __$$_MixerCopyWithImpl(_$_Mixer _value, $Res Function(_$_Mixer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mixerList = null,
    Object? stateFetchAudioMixerPeak = null,
  }) {
    return _then(_$_Mixer(
      mixerList: null == mixerList
          ? _value._mixerList
          : mixerList // ignore: cast_nullable_to_non_nullable
              as List<ProcessVolumeExtended>,
      stateFetchAudioMixerPeak: null == stateFetchAudioMixerPeak
          ? _value.stateFetchAudioMixerPeak
          : stateFetchAudioMixerPeak // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Mixer implements _Mixer {
  _$_Mixer(
      {required final List<ProcessVolumeExtended> mixerList,
      required this.stateFetchAudioMixerPeak})
      : _mixerList = mixerList;

  factory _$_Mixer.fromJson(Map<String, dynamic> json) =>
      _$$_MixerFromJson(json);

  final List<ProcessVolumeExtended> _mixerList;
  @override
  List<ProcessVolumeExtended> get mixerList {
    if (_mixerList is EqualUnmodifiableListView) return _mixerList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mixerList);
  }

  @override
  final bool stateFetchAudioMixerPeak;

  @override
  String toString() {
    return 'Mixer(mixerList: $mixerList, stateFetchAudioMixerPeak: $stateFetchAudioMixerPeak)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Mixer &&
            const DeepCollectionEquality()
                .equals(other._mixerList, _mixerList) &&
            (identical(
                    other.stateFetchAudioMixerPeak, stateFetchAudioMixerPeak) ||
                other.stateFetchAudioMixerPeak == stateFetchAudioMixerPeak));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mixerList),
      stateFetchAudioMixerPeak);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MixerCopyWith<_$_Mixer> get copyWith =>
      __$$_MixerCopyWithImpl<_$_Mixer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MixerToJson(
      this,
    );
  }
}

abstract class _Mixer implements Mixer {
  factory _Mixer(
      {required final List<ProcessVolumeExtended> mixerList,
      required final bool stateFetchAudioMixerPeak}) = _$_Mixer;

  factory _Mixer.fromJson(Map<String, dynamic> json) = _$_Mixer.fromJson;

  @override
  List<ProcessVolumeExtended> get mixerList;
  @override
  bool get stateFetchAudioMixerPeak;
  @override
  @JsonKey(ignore: true)
  _$$_MixerCopyWith<_$_Mixer> get copyWith =>
      throw _privateConstructorUsedError;
}
