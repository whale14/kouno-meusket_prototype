// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UsersState _$UsersStateFromJson(Map<String, dynamic> json) {
  return _UsersState.fromJson(json);
}

/// @nodoc
mixin _$UsersState {
  List<Users> get users => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get myIdx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsersStateCopyWith<UsersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersStateCopyWith<$Res> {
  factory $UsersStateCopyWith(
          UsersState value, $Res Function(UsersState) then) =
      _$UsersStateCopyWithImpl<$Res, UsersState>;
  @useResult
  $Res call({List<Users> users, bool isLoading, String myIdx});
}

/// @nodoc
class _$UsersStateCopyWithImpl<$Res, $Val extends UsersState>
    implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? isLoading = null,
    Object? myIdx = null,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<Users>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      myIdx: null == myIdx
          ? _value.myIdx
          : myIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UsersStateCopyWith<$Res>
    implements $UsersStateCopyWith<$Res> {
  factory _$$_UsersStateCopyWith(
          _$_UsersState value, $Res Function(_$_UsersState) then) =
      __$$_UsersStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Users> users, bool isLoading, String myIdx});
}

/// @nodoc
class __$$_UsersStateCopyWithImpl<$Res>
    extends _$UsersStateCopyWithImpl<$Res, _$_UsersState>
    implements _$$_UsersStateCopyWith<$Res> {
  __$$_UsersStateCopyWithImpl(
      _$_UsersState _value, $Res Function(_$_UsersState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? isLoading = null,
    Object? myIdx = null,
  }) {
    return _then(_$_UsersState(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<Users>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      myIdx: null == myIdx
          ? _value.myIdx
          : myIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UsersState implements _UsersState {
  _$_UsersState(
      {final List<Users> users = const [],
      this.isLoading = false,
      this.myIdx = ''})
      : _users = users;

  factory _$_UsersState.fromJson(Map<String, dynamic> json) =>
      _$$_UsersStateFromJson(json);

  final List<Users> _users;
  @override
  @JsonKey()
  List<Users> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String myIdx;

  @override
  String toString() {
    return 'UsersState(users: $users, isLoading: $isLoading, myIdx: $myIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UsersState &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.myIdx, myIdx) || other.myIdx == myIdx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_users), isLoading, myIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UsersStateCopyWith<_$_UsersState> get copyWith =>
      __$$_UsersStateCopyWithImpl<_$_UsersState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UsersStateToJson(
      this,
    );
  }
}

abstract class _UsersState implements UsersState {
  factory _UsersState(
      {final List<Users> users,
      final bool isLoading,
      final String myIdx}) = _$_UsersState;

  factory _UsersState.fromJson(Map<String, dynamic> json) =
      _$_UsersState.fromJson;

  @override
  List<Users> get users;
  @override
  bool get isLoading;
  @override
  String get myIdx;
  @override
  @JsonKey(ignore: true)
  _$$_UsersStateCopyWith<_$_UsersState> get copyWith =>
      throw _privateConstructorUsedError;
}
