// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waypoint_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WaypointState _$WaypointStateFromJson(Map<String, dynamic> json) {
  return _WaypointState.fromJson(json);
}

/// @nodoc
mixin _$WaypointState {
  List<Waypoint> get waypoints => throw _privateConstructorUsedError;
  Waypoint? get waypoint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaypointStateCopyWith<WaypointState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaypointStateCopyWith<$Res> {
  factory $WaypointStateCopyWith(
          WaypointState value, $Res Function(WaypointState) then) =
      _$WaypointStateCopyWithImpl<$Res, WaypointState>;
  @useResult
  $Res call({List<Waypoint> waypoints, Waypoint? waypoint});

  $WaypointCopyWith<$Res>? get waypoint;
}

/// @nodoc
class _$WaypointStateCopyWithImpl<$Res, $Val extends WaypointState>
    implements $WaypointStateCopyWith<$Res> {
  _$WaypointStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waypoints = null,
    Object? waypoint = freezed,
  }) {
    return _then(_value.copyWith(
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      waypoint: freezed == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as Waypoint?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WaypointCopyWith<$Res>? get waypoint {
    if (_value.waypoint == null) {
      return null;
    }

    return $WaypointCopyWith<$Res>(_value.waypoint!, (value) {
      return _then(_value.copyWith(waypoint: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WaypointStateCopyWith<$Res>
    implements $WaypointStateCopyWith<$Res> {
  factory _$$_WaypointStateCopyWith(
          _$_WaypointState value, $Res Function(_$_WaypointState) then) =
      __$$_WaypointStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Waypoint> waypoints, Waypoint? waypoint});

  @override
  $WaypointCopyWith<$Res>? get waypoint;
}

/// @nodoc
class __$$_WaypointStateCopyWithImpl<$Res>
    extends _$WaypointStateCopyWithImpl<$Res, _$_WaypointState>
    implements _$$_WaypointStateCopyWith<$Res> {
  __$$_WaypointStateCopyWithImpl(
      _$_WaypointState _value, $Res Function(_$_WaypointState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waypoints = null,
    Object? waypoint = freezed,
  }) {
    return _then(_$_WaypointState(
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Waypoint>,
      waypoint: freezed == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as Waypoint?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WaypointState implements _WaypointState {
  _$_WaypointState({final List<Waypoint> waypoints = const [], this.waypoint})
      : _waypoints = waypoints;

  factory _$_WaypointState.fromJson(Map<String, dynamic> json) =>
      _$$_WaypointStateFromJson(json);

  final List<Waypoint> _waypoints;
  @override
  @JsonKey()
  List<Waypoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  final Waypoint? waypoint;

  @override
  String toString() {
    return 'WaypointState(waypoints: $waypoints, waypoint: $waypoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WaypointState &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.waypoint, waypoint) ||
                other.waypoint == waypoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_waypoints), waypoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WaypointStateCopyWith<_$_WaypointState> get copyWith =>
      __$$_WaypointStateCopyWithImpl<_$_WaypointState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WaypointStateToJson(
      this,
    );
  }
}

abstract class _WaypointState implements WaypointState {
  factory _WaypointState(
      {final List<Waypoint> waypoints,
      final Waypoint? waypoint}) = _$_WaypointState;

  factory _WaypointState.fromJson(Map<String, dynamic> json) =
      _$_WaypointState.fromJson;

  @override
  List<Waypoint> get waypoints;
  @override
  Waypoint? get waypoint;
  @override
  @JsonKey(ignore: true)
  _$$_WaypointStateCopyWith<_$_WaypointState> get copyWith =>
      throw _privateConstructorUsedError;
}
