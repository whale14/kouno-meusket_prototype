// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RequestEvent<T> {
  String get idx => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getRequests,
    required TResult Function(String idx) getMyRequestsRequesterSide,
    required TResult Function(String idx) getMyRequestsWorkerSide,
    required TResult Function(String idx, String workerIdx) acceptRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getRequests,
    TResult? Function(String idx)? getMyRequestsRequesterSide,
    TResult? Function(String idx)? getMyRequestsWorkerSide,
    TResult? Function(String idx, String workerIdx)? acceptRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getRequests,
    TResult Function(String idx)? getMyRequestsRequesterSide,
    TResult Function(String idx)? getMyRequestsWorkerSide,
    TResult Function(String idx, String workerIdx)? acceptRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetRequests<T> value) getRequests,
    required TResult Function(GetMyRequestsRequesterSide<T> value)
        getMyRequestsRequesterSide,
    required TResult Function(GetMyRequestsWorkerSide<T> value)
        getMyRequestsWorkerSide,
    required TResult Function(AccpetRequest<T> value) acceptRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetRequests<T> value)? getRequests,
    TResult? Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult? Function(GetMyRequestsWorkerSide<T> value)?
        getMyRequestsWorkerSide,
    TResult? Function(AccpetRequest<T> value)? acceptRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetRequests<T> value)? getRequests,
    TResult Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult Function(GetMyRequestsWorkerSide<T> value)? getMyRequestsWorkerSide,
    TResult Function(AccpetRequest<T> value)? acceptRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestEventCopyWith<T, RequestEvent<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestEventCopyWith<T, $Res> {
  factory $RequestEventCopyWith(
          RequestEvent<T> value, $Res Function(RequestEvent<T>) then) =
      _$RequestEventCopyWithImpl<T, $Res, RequestEvent<T>>;
  @useResult
  $Res call({String idx});
}

/// @nodoc
class _$RequestEventCopyWithImpl<T, $Res, $Val extends RequestEvent<T>>
    implements $RequestEventCopyWith<T, $Res> {
  _$RequestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRequestsCopyWith<T, $Res>
    implements $RequestEventCopyWith<T, $Res> {
  factory _$$GetRequestsCopyWith(
          _$GetRequests<T> value, $Res Function(_$GetRequests<T>) then) =
      __$$GetRequestsCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String idx});
}

/// @nodoc
class __$$GetRequestsCopyWithImpl<T, $Res>
    extends _$RequestEventCopyWithImpl<T, $Res, _$GetRequests<T>>
    implements _$$GetRequestsCopyWith<T, $Res> {
  __$$GetRequestsCopyWithImpl(
      _$GetRequests<T> _value, $Res Function(_$GetRequests<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
  }) {
    return _then(_$GetRequests<T>(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetRequests<T> implements GetRequests<T> {
  const _$GetRequests(this.idx);

  @override
  final String idx;

  @override
  String toString() {
    return 'RequestEvent<$T>.getRequests(idx: $idx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRequests<T> &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRequestsCopyWith<T, _$GetRequests<T>> get copyWith =>
      __$$GetRequestsCopyWithImpl<T, _$GetRequests<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getRequests,
    required TResult Function(String idx) getMyRequestsRequesterSide,
    required TResult Function(String idx) getMyRequestsWorkerSide,
    required TResult Function(String idx, String workerIdx) acceptRequest,
  }) {
    return getRequests(idx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getRequests,
    TResult? Function(String idx)? getMyRequestsRequesterSide,
    TResult? Function(String idx)? getMyRequestsWorkerSide,
    TResult? Function(String idx, String workerIdx)? acceptRequest,
  }) {
    return getRequests?.call(idx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getRequests,
    TResult Function(String idx)? getMyRequestsRequesterSide,
    TResult Function(String idx)? getMyRequestsWorkerSide,
    TResult Function(String idx, String workerIdx)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getRequests != null) {
      return getRequests(idx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetRequests<T> value) getRequests,
    required TResult Function(GetMyRequestsRequesterSide<T> value)
        getMyRequestsRequesterSide,
    required TResult Function(GetMyRequestsWorkerSide<T> value)
        getMyRequestsWorkerSide,
    required TResult Function(AccpetRequest<T> value) acceptRequest,
  }) {
    return getRequests(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetRequests<T> value)? getRequests,
    TResult? Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult? Function(GetMyRequestsWorkerSide<T> value)?
        getMyRequestsWorkerSide,
    TResult? Function(AccpetRequest<T> value)? acceptRequest,
  }) {
    return getRequests?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetRequests<T> value)? getRequests,
    TResult Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult Function(GetMyRequestsWorkerSide<T> value)? getMyRequestsWorkerSide,
    TResult Function(AccpetRequest<T> value)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getRequests != null) {
      return getRequests(this);
    }
    return orElse();
  }
}

abstract class GetRequests<T> implements RequestEvent<T> {
  const factory GetRequests(final String idx) = _$GetRequests<T>;

  @override
  String get idx;
  @override
  @JsonKey(ignore: true)
  _$$GetRequestsCopyWith<T, _$GetRequests<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetMyRequestsRequesterSideCopyWith<T, $Res>
    implements $RequestEventCopyWith<T, $Res> {
  factory _$$GetMyRequestsRequesterSideCopyWith(
          _$GetMyRequestsRequesterSide<T> value,
          $Res Function(_$GetMyRequestsRequesterSide<T>) then) =
      __$$GetMyRequestsRequesterSideCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String idx});
}

/// @nodoc
class __$$GetMyRequestsRequesterSideCopyWithImpl<T, $Res>
    extends _$RequestEventCopyWithImpl<T, $Res, _$GetMyRequestsRequesterSide<T>>
    implements _$$GetMyRequestsRequesterSideCopyWith<T, $Res> {
  __$$GetMyRequestsRequesterSideCopyWithImpl(
      _$GetMyRequestsRequesterSide<T> _value,
      $Res Function(_$GetMyRequestsRequesterSide<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
  }) {
    return _then(_$GetMyRequestsRequesterSide<T>(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetMyRequestsRequesterSide<T> implements GetMyRequestsRequesterSide<T> {
  const _$GetMyRequestsRequesterSide(this.idx);

  @override
  final String idx;

  @override
  String toString() {
    return 'RequestEvent<$T>.getMyRequestsRequesterSide(idx: $idx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetMyRequestsRequesterSide<T> &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetMyRequestsRequesterSideCopyWith<T, _$GetMyRequestsRequesterSide<T>>
      get copyWith => __$$GetMyRequestsRequesterSideCopyWithImpl<T,
          _$GetMyRequestsRequesterSide<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getRequests,
    required TResult Function(String idx) getMyRequestsRequesterSide,
    required TResult Function(String idx) getMyRequestsWorkerSide,
    required TResult Function(String idx, String workerIdx) acceptRequest,
  }) {
    return getMyRequestsRequesterSide(idx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getRequests,
    TResult? Function(String idx)? getMyRequestsRequesterSide,
    TResult? Function(String idx)? getMyRequestsWorkerSide,
    TResult? Function(String idx, String workerIdx)? acceptRequest,
  }) {
    return getMyRequestsRequesterSide?.call(idx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getRequests,
    TResult Function(String idx)? getMyRequestsRequesterSide,
    TResult Function(String idx)? getMyRequestsWorkerSide,
    TResult Function(String idx, String workerIdx)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getMyRequestsRequesterSide != null) {
      return getMyRequestsRequesterSide(idx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetRequests<T> value) getRequests,
    required TResult Function(GetMyRequestsRequesterSide<T> value)
        getMyRequestsRequesterSide,
    required TResult Function(GetMyRequestsWorkerSide<T> value)
        getMyRequestsWorkerSide,
    required TResult Function(AccpetRequest<T> value) acceptRequest,
  }) {
    return getMyRequestsRequesterSide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetRequests<T> value)? getRequests,
    TResult? Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult? Function(GetMyRequestsWorkerSide<T> value)?
        getMyRequestsWorkerSide,
    TResult? Function(AccpetRequest<T> value)? acceptRequest,
  }) {
    return getMyRequestsRequesterSide?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetRequests<T> value)? getRequests,
    TResult Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult Function(GetMyRequestsWorkerSide<T> value)? getMyRequestsWorkerSide,
    TResult Function(AccpetRequest<T> value)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getMyRequestsRequesterSide != null) {
      return getMyRequestsRequesterSide(this);
    }
    return orElse();
  }
}

abstract class GetMyRequestsRequesterSide<T> implements RequestEvent<T> {
  const factory GetMyRequestsRequesterSide(final String idx) =
      _$GetMyRequestsRequesterSide<T>;

  @override
  String get idx;
  @override
  @JsonKey(ignore: true)
  _$$GetMyRequestsRequesterSideCopyWith<T, _$GetMyRequestsRequesterSide<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetMyRequestsWorkerSideCopyWith<T, $Res>
    implements $RequestEventCopyWith<T, $Res> {
  factory _$$GetMyRequestsWorkerSideCopyWith(_$GetMyRequestsWorkerSide<T> value,
          $Res Function(_$GetMyRequestsWorkerSide<T>) then) =
      __$$GetMyRequestsWorkerSideCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String idx});
}

/// @nodoc
class __$$GetMyRequestsWorkerSideCopyWithImpl<T, $Res>
    extends _$RequestEventCopyWithImpl<T, $Res, _$GetMyRequestsWorkerSide<T>>
    implements _$$GetMyRequestsWorkerSideCopyWith<T, $Res> {
  __$$GetMyRequestsWorkerSideCopyWithImpl(_$GetMyRequestsWorkerSide<T> _value,
      $Res Function(_$GetMyRequestsWorkerSide<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
  }) {
    return _then(_$GetMyRequestsWorkerSide<T>(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetMyRequestsWorkerSide<T> implements GetMyRequestsWorkerSide<T> {
  const _$GetMyRequestsWorkerSide(this.idx);

  @override
  final String idx;

  @override
  String toString() {
    return 'RequestEvent<$T>.getMyRequestsWorkerSide(idx: $idx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetMyRequestsWorkerSide<T> &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetMyRequestsWorkerSideCopyWith<T, _$GetMyRequestsWorkerSide<T>>
      get copyWith => __$$GetMyRequestsWorkerSideCopyWithImpl<T,
          _$GetMyRequestsWorkerSide<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getRequests,
    required TResult Function(String idx) getMyRequestsRequesterSide,
    required TResult Function(String idx) getMyRequestsWorkerSide,
    required TResult Function(String idx, String workerIdx) acceptRequest,
  }) {
    return getMyRequestsWorkerSide(idx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getRequests,
    TResult? Function(String idx)? getMyRequestsRequesterSide,
    TResult? Function(String idx)? getMyRequestsWorkerSide,
    TResult? Function(String idx, String workerIdx)? acceptRequest,
  }) {
    return getMyRequestsWorkerSide?.call(idx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getRequests,
    TResult Function(String idx)? getMyRequestsRequesterSide,
    TResult Function(String idx)? getMyRequestsWorkerSide,
    TResult Function(String idx, String workerIdx)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getMyRequestsWorkerSide != null) {
      return getMyRequestsWorkerSide(idx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetRequests<T> value) getRequests,
    required TResult Function(GetMyRequestsRequesterSide<T> value)
        getMyRequestsRequesterSide,
    required TResult Function(GetMyRequestsWorkerSide<T> value)
        getMyRequestsWorkerSide,
    required TResult Function(AccpetRequest<T> value) acceptRequest,
  }) {
    return getMyRequestsWorkerSide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetRequests<T> value)? getRequests,
    TResult? Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult? Function(GetMyRequestsWorkerSide<T> value)?
        getMyRequestsWorkerSide,
    TResult? Function(AccpetRequest<T> value)? acceptRequest,
  }) {
    return getMyRequestsWorkerSide?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetRequests<T> value)? getRequests,
    TResult Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult Function(GetMyRequestsWorkerSide<T> value)? getMyRequestsWorkerSide,
    TResult Function(AccpetRequest<T> value)? acceptRequest,
    required TResult orElse(),
  }) {
    if (getMyRequestsWorkerSide != null) {
      return getMyRequestsWorkerSide(this);
    }
    return orElse();
  }
}

abstract class GetMyRequestsWorkerSide<T> implements RequestEvent<T> {
  const factory GetMyRequestsWorkerSide(final String idx) =
      _$GetMyRequestsWorkerSide<T>;

  @override
  String get idx;
  @override
  @JsonKey(ignore: true)
  _$$GetMyRequestsWorkerSideCopyWith<T, _$GetMyRequestsWorkerSide<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccpetRequestCopyWith<T, $Res>
    implements $RequestEventCopyWith<T, $Res> {
  factory _$$AccpetRequestCopyWith(
          _$AccpetRequest<T> value, $Res Function(_$AccpetRequest<T>) then) =
      __$$AccpetRequestCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String idx, String workerIdx});
}

/// @nodoc
class __$$AccpetRequestCopyWithImpl<T, $Res>
    extends _$RequestEventCopyWithImpl<T, $Res, _$AccpetRequest<T>>
    implements _$$AccpetRequestCopyWith<T, $Res> {
  __$$AccpetRequestCopyWithImpl(
      _$AccpetRequest<T> _value, $Res Function(_$AccpetRequest<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? workerIdx = null,
  }) {
    return _then(_$AccpetRequest<T>(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
      null == workerIdx
          ? _value.workerIdx
          : workerIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccpetRequest<T> implements AccpetRequest<T> {
  const _$AccpetRequest(this.idx, this.workerIdx);

  @override
  final String idx;
  @override
  final String workerIdx;

  @override
  String toString() {
    return 'RequestEvent<$T>.acceptRequest(idx: $idx, workerIdx: $workerIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccpetRequest<T> &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.workerIdx, workerIdx) ||
                other.workerIdx == workerIdx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx, workerIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccpetRequestCopyWith<T, _$AccpetRequest<T>> get copyWith =>
      __$$AccpetRequestCopyWithImpl<T, _$AccpetRequest<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getRequests,
    required TResult Function(String idx) getMyRequestsRequesterSide,
    required TResult Function(String idx) getMyRequestsWorkerSide,
    required TResult Function(String idx, String workerIdx) acceptRequest,
  }) {
    return acceptRequest(idx, workerIdx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getRequests,
    TResult? Function(String idx)? getMyRequestsRequesterSide,
    TResult? Function(String idx)? getMyRequestsWorkerSide,
    TResult? Function(String idx, String workerIdx)? acceptRequest,
  }) {
    return acceptRequest?.call(idx, workerIdx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getRequests,
    TResult Function(String idx)? getMyRequestsRequesterSide,
    TResult Function(String idx)? getMyRequestsWorkerSide,
    TResult Function(String idx, String workerIdx)? acceptRequest,
    required TResult orElse(),
  }) {
    if (acceptRequest != null) {
      return acceptRequest(idx, workerIdx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetRequests<T> value) getRequests,
    required TResult Function(GetMyRequestsRequesterSide<T> value)
        getMyRequestsRequesterSide,
    required TResult Function(GetMyRequestsWorkerSide<T> value)
        getMyRequestsWorkerSide,
    required TResult Function(AccpetRequest<T> value) acceptRequest,
  }) {
    return acceptRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetRequests<T> value)? getRequests,
    TResult? Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult? Function(GetMyRequestsWorkerSide<T> value)?
        getMyRequestsWorkerSide,
    TResult? Function(AccpetRequest<T> value)? acceptRequest,
  }) {
    return acceptRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetRequests<T> value)? getRequests,
    TResult Function(GetMyRequestsRequesterSide<T> value)?
        getMyRequestsRequesterSide,
    TResult Function(GetMyRequestsWorkerSide<T> value)? getMyRequestsWorkerSide,
    TResult Function(AccpetRequest<T> value)? acceptRequest,
    required TResult orElse(),
  }) {
    if (acceptRequest != null) {
      return acceptRequest(this);
    }
    return orElse();
  }
}

abstract class AccpetRequest<T> implements RequestEvent<T> {
  const factory AccpetRequest(final String idx, final String workerIdx) =
      _$AccpetRequest<T>;

  @override
  String get idx;
  String get workerIdx;
  @override
  @JsonKey(ignore: true)
  _$$AccpetRequestCopyWith<T, _$AccpetRequest<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
