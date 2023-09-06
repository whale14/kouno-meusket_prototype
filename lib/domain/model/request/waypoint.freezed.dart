// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waypoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Waypoint _$WaypointFromJson(Map<String, dynamic> json) {
  return _Waypoint.fromJson(json);
}

/// @nodoc
mixin _$Waypoint {
  int get idx => throw _privateConstructorUsedError;
  int get requestIdx => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaypointCopyWith<Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaypointCopyWith<$Res> {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) then) =
      _$WaypointCopyWithImpl<$Res, Waypoint>;
  @useResult
  $Res call(
      {int idx,
      int requestIdx,
      String content,
      double latitude,
      double longitude,
      String address});
}

/// @nodoc
class _$WaypointCopyWithImpl<$Res, $Val extends Waypoint>
    implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? content = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WaypointCopyWith<$Res> implements $WaypointCopyWith<$Res> {
  factory _$$_WaypointCopyWith(
          _$_Waypoint value, $Res Function(_$_Waypoint) then) =
      __$$_WaypointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      int requestIdx,
      String content,
      double latitude,
      double longitude,
      String address});
}

/// @nodoc
class __$$_WaypointCopyWithImpl<$Res>
    extends _$WaypointCopyWithImpl<$Res, _$_Waypoint>
    implements _$$_WaypointCopyWith<$Res> {
  __$$_WaypointCopyWithImpl(
      _$_Waypoint _value, $Res Function(_$_Waypoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? content = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
  }) {
    return _then(_$_Waypoint(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Waypoint implements _Waypoint {
  _$_Waypoint(
      {required this.idx,
      required this.requestIdx,
      required this.content,
      required this.latitude,
      required this.longitude,
      required this.address});

  factory _$_Waypoint.fromJson(Map<String, dynamic> json) =>
      _$$_WaypointFromJson(json);

  @override
  final int idx;
  @override
  final int requestIdx;
  @override
  final String content;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String address;

  @override
  String toString() {
    return 'Waypoint(idx: $idx, requestIdx: $requestIdx, content: $content, latitude: $latitude, longitude: $longitude, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Waypoint &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.requestIdx, requestIdx) ||
                other.requestIdx == requestIdx) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, idx, requestIdx, content, latitude, longitude, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WaypointCopyWith<_$_Waypoint> get copyWith =>
      __$$_WaypointCopyWithImpl<_$_Waypoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WaypointToJson(
      this,
    );
  }
}

abstract class _Waypoint implements Waypoint {
  factory _Waypoint(
      {required final int idx,
      required final int requestIdx,
      required final String content,
      required final double latitude,
      required final double longitude,
      required final String address}) = _$_Waypoint;

  factory _Waypoint.fromJson(Map<String, dynamic> json) = _$_Waypoint.fromJson;

  @override
  int get idx;
  @override
  int get requestIdx;
  @override
  String get content;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_WaypointCopyWith<_$_Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}
