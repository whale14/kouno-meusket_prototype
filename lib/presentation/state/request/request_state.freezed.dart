// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestState _$RequestStateFromJson(Map<String, dynamic> json) {
  return _RequestState.fromJson(json);
}

/// @nodoc
mixin _$RequestState {
  List<Request> get requests => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestStateCopyWith<RequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestStateCopyWith<$Res> {
  factory $RequestStateCopyWith(
          RequestState value, $Res Function(RequestState) then) =
      _$RequestStateCopyWithImpl<$Res, RequestState>;
  @useResult
  $Res call({List<Request> requests});
}

/// @nodoc
class _$RequestStateCopyWithImpl<$Res, $Val extends RequestState>
    implements $RequestStateCopyWith<$Res> {
  _$RequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
  }) {
    return _then(_value.copyWith(
      requests: null == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<Request>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RequestStateCopyWith<$Res>
    implements $RequestStateCopyWith<$Res> {
  factory _$$_RequestStateCopyWith(
          _$_RequestState value, $Res Function(_$_RequestState) then) =
      __$$_RequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Request> requests});
}

/// @nodoc
class __$$_RequestStateCopyWithImpl<$Res>
    extends _$RequestStateCopyWithImpl<$Res, _$_RequestState>
    implements _$$_RequestStateCopyWith<$Res> {
  __$$_RequestStateCopyWithImpl(
      _$_RequestState _value, $Res Function(_$_RequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
  }) {
    return _then(_$_RequestState(
      requests: null == requests
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<Request>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestState implements _RequestState {
  _$_RequestState({final List<Request> requests = const []})
      : _requests = requests;

  factory _$_RequestState.fromJson(Map<String, dynamic> json) =>
      _$$_RequestStateFromJson(json);

  final List<Request> _requests;
  @override
  @JsonKey()
  List<Request> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'RequestState(requests: $requests)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestState &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_requests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestStateCopyWith<_$_RequestState> get copyWith =>
      __$$_RequestStateCopyWithImpl<_$_RequestState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestStateToJson(
      this,
    );
  }
}

abstract class _RequestState implements RequestState {
  factory _RequestState({final List<Request> requests}) = _$_RequestState;

  factory _RequestState.fromJson(Map<String, dynamic> json) =
      _$_RequestState.fromJson;

  @override
  List<Request> get requests;
  @override
  @JsonKey(ignore: true)
  _$$_RequestStateCopyWith<_$_RequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
