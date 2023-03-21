// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getUser,
    required TResult Function(String idx, double latitude, double longitude)
        updateLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getUser,
    TResult? Function(String idx, double latitude, double longitude)?
        updateLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getUser,
    TResult Function(String idx, double latitude, double longitude)?
        updateLocation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetUser value) getUser,
    required TResult Function(UpdateLocation value) updateLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetUser value)? getUser,
    TResult? Function(UpdateLocation value)? updateLocation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetUser value)? getUser,
    TResult Function(UpdateLocation value)? updateLocation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetUserCopyWith<$Res> {
  factory _$$GetUserCopyWith(_$GetUser value, $Res Function(_$GetUser) then) =
      __$$GetUserCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$GetUserCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$GetUser>
    implements _$$GetUserCopyWith<$Res> {
  __$$GetUserCopyWithImpl(_$GetUser _value, $Res Function(_$GetUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$GetUser(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetUser implements GetUser {
  const _$GetUser(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'UserEvent.getUser(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetUser &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetUserCopyWith<_$GetUser> get copyWith =>
      __$$GetUserCopyWithImpl<_$GetUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getUser,
    required TResult Function(String idx, double latitude, double longitude)
        updateLocation,
  }) {
    return getUser(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getUser,
    TResult? Function(String idx, double latitude, double longitude)?
        updateLocation,
  }) {
    return getUser?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getUser,
    TResult Function(String idx, double latitude, double longitude)?
        updateLocation,
    required TResult orElse(),
  }) {
    if (getUser != null) {
      return getUser(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetUser value) getUser,
    required TResult Function(UpdateLocation value) updateLocation,
  }) {
    return getUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetUser value)? getUser,
    TResult? Function(UpdateLocation value)? updateLocation,
  }) {
    return getUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetUser value)? getUser,
    TResult Function(UpdateLocation value)? updateLocation,
    required TResult orElse(),
  }) {
    if (getUser != null) {
      return getUser(this);
    }
    return orElse();
  }
}

abstract class GetUser implements UserEvent {
  const factory GetUser(final String id) = _$GetUser;

  String get id;
  @JsonKey(ignore: true)
  _$$GetUserCopyWith<_$GetUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateLocationCopyWith<$Res> {
  factory _$$UpdateLocationCopyWith(
          _$UpdateLocation value, $Res Function(_$UpdateLocation) then) =
      __$$UpdateLocationCopyWithImpl<$Res>;
  @useResult
  $Res call({String idx, double latitude, double longitude});
}

/// @nodoc
class __$$UpdateLocationCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$UpdateLocation>
    implements _$$UpdateLocationCopyWith<$Res> {
  __$$UpdateLocationCopyWithImpl(
      _$UpdateLocation _value, $Res Function(_$UpdateLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$UpdateLocation(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
      null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$UpdateLocation implements UpdateLocation {
  const _$UpdateLocation(this.idx, this.latitude, this.longitude);

  @override
  final String idx;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'UserEvent.updateLocation(idx: $idx, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLocation &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLocationCopyWith<_$UpdateLocation> get copyWith =>
      __$$UpdateLocationCopyWithImpl<_$UpdateLocation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getUser,
    required TResult Function(String idx, double latitude, double longitude)
        updateLocation,
  }) {
    return updateLocation(idx, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getUser,
    TResult? Function(String idx, double latitude, double longitude)?
        updateLocation,
  }) {
    return updateLocation?.call(idx, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getUser,
    TResult Function(String idx, double latitude, double longitude)?
        updateLocation,
    required TResult orElse(),
  }) {
    if (updateLocation != null) {
      return updateLocation(idx, latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetUser value) getUser,
    required TResult Function(UpdateLocation value) updateLocation,
  }) {
    return updateLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetUser value)? getUser,
    TResult? Function(UpdateLocation value)? updateLocation,
  }) {
    return updateLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetUser value)? getUser,
    TResult Function(UpdateLocation value)? updateLocation,
    required TResult orElse(),
  }) {
    if (updateLocation != null) {
      return updateLocation(this);
    }
    return orElse();
  }
}

abstract class UpdateLocation implements UserEvent {
  const factory UpdateLocation(
          final String idx, final double latitude, final double longitude) =
      _$UpdateLocation;

  String get idx;
  double get latitude;
  double get longitude;
  @JsonKey(ignore: true)
  _$$UpdateLocationCopyWith<_$UpdateLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
