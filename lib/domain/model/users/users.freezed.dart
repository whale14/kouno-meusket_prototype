// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Users _$UsersFromJson(Map<String, dynamic> json) {
  return _Users.fromJson(json);
}

/// @nodoc
mixin _$Users {
  int get idx => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get createAt => throw _privateConstructorUsedError;
  String get updateAt => throw _privateConstructorUsedError;
  int get doingState => throw _privateConstructorUsedError;
  int get accountState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsersCopyWith<Users> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersCopyWith<$Res> {
  factory $UsersCopyWith(Users value, $Res Function(Users) then) =
      _$UsersCopyWithImpl<$Res, Users>;
  @useResult
  $Res call(
      {int idx,
      String id,
      String name,
      double latitude,
      double longitude,
      String createAt,
      String updateAt,
      int doingState,
      int accountState});
}

/// @nodoc
class _$UsersCopyWithImpl<$Res, $Val extends Users>
    implements $UsersCopyWith<$Res> {
  _$UsersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? createAt = null,
    Object? updateAt = null,
    Object? doingState = null,
    Object? accountState = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: null == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String,
      doingState: null == doingState
          ? _value.doingState
          : doingState // ignore: cast_nullable_to_non_nullable
              as int,
      accountState: null == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UsersCopyWith<$Res> implements $UsersCopyWith<$Res> {
  factory _$$_UsersCopyWith(_$_Users value, $Res Function(_$_Users) then) =
      __$$_UsersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      String id,
      String name,
      double latitude,
      double longitude,
      String createAt,
      String updateAt,
      int doingState,
      int accountState});
}

/// @nodoc
class __$$_UsersCopyWithImpl<$Res> extends _$UsersCopyWithImpl<$Res, _$_Users>
    implements _$$_UsersCopyWith<$Res> {
  __$$_UsersCopyWithImpl(_$_Users _value, $Res Function(_$_Users) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? createAt = null,
    Object? updateAt = null,
    Object? doingState = null,
    Object? accountState = null,
  }) {
    return _then(_$_Users(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: null == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String,
      doingState: null == doingState
          ? _value.doingState
          : doingState // ignore: cast_nullable_to_non_nullable
              as int,
      accountState: null == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Users implements _Users {
  _$_Users(
      {required this.idx,
      required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.createAt,
      required this.updateAt,
      required this.doingState,
      required this.accountState});

  factory _$_Users.fromJson(Map<String, dynamic> json) =>
      _$$_UsersFromJson(json);

  @override
  final int idx;
  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String createAt;
  @override
  final String updateAt;
  @override
  final int doingState;
  @override
  final int accountState;

  @override
  String toString() {
    return 'Users(idx: $idx, id: $id, name: $name, latitude: $latitude, longitude: $longitude, createAt: $createAt, updateAt: $updateAt, doingState: $doingState, accountState: $accountState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Users &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.doingState, doingState) ||
                other.doingState == doingState) &&
            (identical(other.accountState, accountState) ||
                other.accountState == accountState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idx, id, name, latitude,
      longitude, createAt, updateAt, doingState, accountState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UsersCopyWith<_$_Users> get copyWith =>
      __$$_UsersCopyWithImpl<_$_Users>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UsersToJson(
      this,
    );
  }
}

abstract class _Users implements Users {
  factory _Users(
      {required final int idx,
      required final String id,
      required final String name,
      required final double latitude,
      required final double longitude,
      required final String createAt,
      required final String updateAt,
      required final int doingState,
      required final int accountState}) = _$_Users;

  factory _Users.fromJson(Map<String, dynamic> json) = _$_Users.fromJson;

  @override
  int get idx;
  @override
  String get id;
  @override
  String get name;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get createAt;
  @override
  String get updateAt;
  @override
  int get doingState;
  @override
  int get accountState;
  @override
  @JsonKey(ignore: true)
  _$$_UsersCopyWith<_$_Users> get copyWith =>
      throw _privateConstructorUsedError;
}
