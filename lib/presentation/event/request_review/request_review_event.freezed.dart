// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_review_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RequestReviewEvent<T> {
  String get toIdx => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String toIdx) getReviews,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String toIdx)? getReviews,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String toIdx)? getReviews,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetReviews<T> value) getReviews,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetReviews<T> value)? getReviews,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetReviews<T> value)? getReviews,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestReviewEventCopyWith<T, RequestReviewEvent<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestReviewEventCopyWith<T, $Res> {
  factory $RequestReviewEventCopyWith(RequestReviewEvent<T> value,
          $Res Function(RequestReviewEvent<T>) then) =
      _$RequestReviewEventCopyWithImpl<T, $Res, RequestReviewEvent<T>>;
  @useResult
  $Res call({String toIdx});
}

/// @nodoc
class _$RequestReviewEventCopyWithImpl<T, $Res,
        $Val extends RequestReviewEvent<T>>
    implements $RequestReviewEventCopyWith<T, $Res> {
  _$RequestReviewEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toIdx = null,
  }) {
    return _then(_value.copyWith(
      toIdx: null == toIdx
          ? _value.toIdx
          : toIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetReviewsCopyWith<T, $Res>
    implements $RequestReviewEventCopyWith<T, $Res> {
  factory _$$GetReviewsCopyWith(
          _$GetReviews<T> value, $Res Function(_$GetReviews<T>) then) =
      __$$GetReviewsCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String toIdx});
}

/// @nodoc
class __$$GetReviewsCopyWithImpl<T, $Res>
    extends _$RequestReviewEventCopyWithImpl<T, $Res, _$GetReviews<T>>
    implements _$$GetReviewsCopyWith<T, $Res> {
  __$$GetReviewsCopyWithImpl(
      _$GetReviews<T> _value, $Res Function(_$GetReviews<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toIdx = null,
  }) {
    return _then(_$GetReviews<T>(
      null == toIdx
          ? _value.toIdx
          : toIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetReviews<T> implements GetReviews<T> {
  const _$GetReviews(this.toIdx);

  @override
  final String toIdx;

  @override
  String toString() {
    return 'RequestReviewEvent<$T>.getReviews(toIdx: $toIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetReviews<T> &&
            (identical(other.toIdx, toIdx) || other.toIdx == toIdx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetReviewsCopyWith<T, _$GetReviews<T>> get copyWith =>
      __$$GetReviewsCopyWithImpl<T, _$GetReviews<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String toIdx) getReviews,
  }) {
    return getReviews(toIdx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String toIdx)? getReviews,
  }) {
    return getReviews?.call(toIdx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String toIdx)? getReviews,
    required TResult orElse(),
  }) {
    if (getReviews != null) {
      return getReviews(toIdx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetReviews<T> value) getReviews,
  }) {
    return getReviews(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetReviews<T> value)? getReviews,
  }) {
    return getReviews?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetReviews<T> value)? getReviews,
    required TResult orElse(),
  }) {
    if (getReviews != null) {
      return getReviews(this);
    }
    return orElse();
  }
}

abstract class GetReviews<T> implements RequestReviewEvent<T> {
  const factory GetReviews(final String toIdx) = _$GetReviews<T>;

  @override
  String get toIdx;
  @override
  @JsonKey(ignore: true)
  _$$GetReviewsCopyWith<T, _$GetReviews<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
