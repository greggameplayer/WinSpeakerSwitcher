// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Home _$HomeFromJson(Map<String, dynamic> json) {
  return _Home.fromJson(json);
}

/// @nodoc
mixin _$Home {
  AudioDeviceExtended get defaultDevice => throw _privateConstructorUsedError;
  bool get initialized => throw _privateConstructorUsedError;
  AudioDeviceType get audioDeviceType => throw _privateConstructorUsedError;
  List<AudioDeviceExtended> get audioDevices =>
      throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  String get fetchStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeCopyWith<Home> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeCopyWith<$Res> {
  factory $HomeCopyWith(Home value, $Res Function(Home) then) =
      _$HomeCopyWithImpl<$Res, Home>;
  @useResult
  $Res call(
      {AudioDeviceExtended defaultDevice,
      bool initialized,
      AudioDeviceType audioDeviceType,
      List<AudioDeviceExtended> audioDevices,
      double volume,
      String fetchStatus});
}

/// @nodoc
class _$HomeCopyWithImpl<$Res, $Val extends Home>
    implements $HomeCopyWith<$Res> {
  _$HomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDevice = null,
    Object? initialized = null,
    Object? audioDeviceType = null,
    Object? audioDevices = null,
    Object? volume = null,
    Object? fetchStatus = null,
  }) {
    return _then(_value.copyWith(
      defaultDevice: null == defaultDevice
          ? _value.defaultDevice
          : defaultDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceExtended,
      initialized: null == initialized
          ? _value.initialized
          : initialized // ignore: cast_nullable_to_non_nullable
              as bool,
      audioDeviceType: null == audioDeviceType
          ? _value.audioDeviceType
          : audioDeviceType // ignore: cast_nullable_to_non_nullable
              as AudioDeviceType,
      audioDevices: null == audioDevices
          ? _value.audioDevices
          : audioDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceExtended>,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      fetchStatus: null == fetchStatus
          ? _value.fetchStatus
          : fetchStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeCopyWith<$Res> implements $HomeCopyWith<$Res> {
  factory _$$_HomeCopyWith(_$_Home value, $Res Function(_$_Home) then) =
      __$$_HomeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AudioDeviceExtended defaultDevice,
      bool initialized,
      AudioDeviceType audioDeviceType,
      List<AudioDeviceExtended> audioDevices,
      double volume,
      String fetchStatus});
}

/// @nodoc
class __$$_HomeCopyWithImpl<$Res> extends _$HomeCopyWithImpl<$Res, _$_Home>
    implements _$$_HomeCopyWith<$Res> {
  __$$_HomeCopyWithImpl(_$_Home _value, $Res Function(_$_Home) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultDevice = null,
    Object? initialized = null,
    Object? audioDeviceType = null,
    Object? audioDevices = null,
    Object? volume = null,
    Object? fetchStatus = null,
  }) {
    return _then(_$_Home(
      defaultDevice: null == defaultDevice
          ? _value.defaultDevice
          : defaultDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceExtended,
      initialized: null == initialized
          ? _value.initialized
          : initialized // ignore: cast_nullable_to_non_nullable
              as bool,
      audioDeviceType: null == audioDeviceType
          ? _value.audioDeviceType
          : audioDeviceType // ignore: cast_nullable_to_non_nullable
              as AudioDeviceType,
      audioDevices: null == audioDevices
          ? _value._audioDevices
          : audioDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceExtended>,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      fetchStatus: null == fetchStatus
          ? _value.fetchStatus
          : fetchStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Home implements _Home {
  _$_Home(
      {required this.defaultDevice,
      required this.initialized,
      required this.audioDeviceType,
      required final List<AudioDeviceExtended> audioDevices,
      required this.volume,
      required this.fetchStatus})
      : _audioDevices = audioDevices;

  factory _$_Home.fromJson(Map<String, dynamic> json) => _$$_HomeFromJson(json);

  @override
  final AudioDeviceExtended defaultDevice;
  @override
  final bool initialized;
  @override
  final AudioDeviceType audioDeviceType;
  final List<AudioDeviceExtended> _audioDevices;
  @override
  List<AudioDeviceExtended> get audioDevices {
    if (_audioDevices is EqualUnmodifiableListView) return _audioDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioDevices);
  }

  @override
  final double volume;
  @override
  final String fetchStatus;

  @override
  String toString() {
    return 'Home(defaultDevice: $defaultDevice, initialized: $initialized, audioDeviceType: $audioDeviceType, audioDevices: $audioDevices, volume: $volume, fetchStatus: $fetchStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Home &&
            (identical(other.defaultDevice, defaultDevice) ||
                other.defaultDevice == defaultDevice) &&
            (identical(other.initialized, initialized) ||
                other.initialized == initialized) &&
            (identical(other.audioDeviceType, audioDeviceType) ||
                other.audioDeviceType == audioDeviceType) &&
            const DeepCollectionEquality()
                .equals(other._audioDevices, _audioDevices) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.fetchStatus, fetchStatus) ||
                other.fetchStatus == fetchStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultDevice,
      initialized,
      audioDeviceType,
      const DeepCollectionEquality().hash(_audioDevices),
      volume,
      fetchStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeCopyWith<_$_Home> get copyWith =>
      __$$_HomeCopyWithImpl<_$_Home>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeToJson(
      this,
    );
  }
}

abstract class _Home implements Home {
  factory _Home(
      {required final AudioDeviceExtended defaultDevice,
      required final bool initialized,
      required final AudioDeviceType audioDeviceType,
      required final List<AudioDeviceExtended> audioDevices,
      required final double volume,
      required final String fetchStatus}) = _$_Home;

  factory _Home.fromJson(Map<String, dynamic> json) = _$_Home.fromJson;

  @override
  AudioDeviceExtended get defaultDevice;
  @override
  bool get initialized;
  @override
  AudioDeviceType get audioDeviceType;
  @override
  List<AudioDeviceExtended> get audioDevices;
  @override
  double get volume;
  @override
  String get fetchStatus;
  @override
  @JsonKey(ignore: true)
  _$$_HomeCopyWith<_$_Home> get copyWith => throw _privateConstructorUsedError;
}
