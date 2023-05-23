// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OtherUserState _$OtherUserStateFromJson(Map<String, dynamic> json) {
  return _OtherUserState.fromJson(json);
}

/// @nodoc
mixin _$OtherUserState {
  User? get user => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtherUserStateCopyWith<OtherUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtherUserStateCopyWith<$Res> {
  factory $OtherUserStateCopyWith(
          OtherUserState value, $Res Function(OtherUserState) then) =
      _$OtherUserStateCopyWithImpl<$Res, OtherUserState>;
  @useResult
  $Res call({User? user, bool isLoading});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$OtherUserStateCopyWithImpl<$Res, $Val extends OtherUserState>
    implements $OtherUserStateCopyWith<$Res> {
  _$OtherUserStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_OtherUserStateCopyWith<$Res>
    implements $OtherUserStateCopyWith<$Res> {
  factory _$$_OtherUserStateCopyWith(
          _$_OtherUserState value, $Res Function(_$_OtherUserState) then) =
      __$$_OtherUserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User? user, bool isLoading});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_OtherUserStateCopyWithImpl<$Res>
    extends _$OtherUserStateCopyWithImpl<$Res, _$_OtherUserState>
    implements _$$_OtherUserStateCopyWith<$Res> {
  __$$_OtherUserStateCopyWithImpl(
      _$_OtherUserState _value, $Res Function(_$_OtherUserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_OtherUserState(
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
class _$_OtherUserState implements _OtherUserState {
  _$_OtherUserState({this.user, this.isLoading = false});

  factory _$_OtherUserState.fromJson(Map<String, dynamic> json) =>
      _$$_OtherUserStateFromJson(json);

  @override
  final User? user;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'OtherUserState(user: $user, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OtherUserState &&
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
  _$$_OtherUserStateCopyWith<_$_OtherUserState> get copyWith =>
      __$$_OtherUserStateCopyWithImpl<_$_OtherUserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OtherUserStateToJson(
      this,
    );
  }
}

abstract class _OtherUserState implements OtherUserState {
  factory _OtherUserState({final User? user, final bool isLoading}) =
      _$_OtherUserState;

  factory _OtherUserState.fromJson(Map<String, dynamic> json) =
      _$_OtherUserState.fromJson;

  @override
  User? get user;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_OtherUserStateCopyWith<_$_OtherUserState> get copyWith =>
      throw _privateConstructorUsedError;
}
