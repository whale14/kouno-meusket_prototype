// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserState<T> _$UserStateFromJson<T>(Map<String, dynamic> json) {
  return _UserState<T>.fromJson(json);
}

/// @nodoc
mixin _$UserState<T> {
  User? get user => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStateCopyWith<T, UserState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<T, $Res> {
  factory $UserStateCopyWith(
          UserState<T> value, $Res Function(UserState<T>) then) =
      _$UserStateCopyWithImpl<T, $Res, UserState<T>>;
  @useResult
  $Res call({User? user, bool isLoading});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserStateCopyWithImpl<T, $Res, $Val extends UserState<T>>
    implements $UserStateCopyWith<T, $Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserStateCopyWith<T, $Res>
    implements $UserStateCopyWith<T, $Res> {
  factory _$$_UserStateCopyWith(
          _$_UserState<T> value, $Res Function(_$_UserState<T>) then) =
      __$$_UserStateCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({User? user, bool isLoading});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_UserStateCopyWithImpl<T, $Res>
    extends _$UserStateCopyWithImpl<T, $Res, _$_UserState<T>>
    implements _$$_UserStateCopyWith<T, $Res> {
  __$$_UserStateCopyWithImpl(
      _$_UserState<T> _value, $Res Function(_$_UserState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_UserState<T>(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserState<T> implements _UserState<T> {
  _$_UserState({this.user, this.isLoading = false});

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$$_UserStateFromJson(json);

  @override
  final User? user;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'UserState<$T>(user: $user, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserState<T> &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStateCopyWith<T, _$_UserState<T>> get copyWith =>
      __$$_UserStateCopyWithImpl<T, _$_UserState<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStateToJson<T>(
      this,
    );
  }
}

abstract class _UserState<T> implements UserState<T> {
  factory _UserState({final User? user, final bool isLoading}) =
      _$_UserState<T>;

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState<T>.fromJson;

  @override
  User? get user;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_UserStateCopyWith<T, _$_UserState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
