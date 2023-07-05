// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestReviewState _$RequestReviewStateFromJson(Map<String, dynamic> json) {
  return _RequestReviewState.fromJson(json);
}

/// @nodoc
mixin _$RequestReviewState {
  List<RequestReview> get requestReviews => throw _privateConstructorUsedError;
  RequestReview? get requestReview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestReviewStateCopyWith<RequestReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestReviewStateCopyWith<$Res> {
  factory $RequestReviewStateCopyWith(
          RequestReviewState value, $Res Function(RequestReviewState) then) =
      _$RequestReviewStateCopyWithImpl<$Res, RequestReviewState>;
  @useResult
  $Res call({List<RequestReview> requestReviews, RequestReview? requestReview});

  $RequestReviewCopyWith<$Res>? get requestReview;
}

/// @nodoc
class _$RequestReviewStateCopyWithImpl<$Res, $Val extends RequestReviewState>
    implements $RequestReviewStateCopyWith<$Res> {
  _$RequestReviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestReviews = null,
    Object? requestReview = freezed,
  }) {
    return _then(_value.copyWith(
      requestReviews: null == requestReviews
          ? _value.requestReviews
          : requestReviews // ignore: cast_nullable_to_non_nullable
              as List<RequestReview>,
      requestReview: freezed == requestReview
          ? _value.requestReview
          : requestReview // ignore: cast_nullable_to_non_nullable
              as RequestReview?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RequestReviewCopyWith<$Res>? get requestReview {
    if (_value.requestReview == null) {
      return null;
    }

    return $RequestReviewCopyWith<$Res>(_value.requestReview!, (value) {
      return _then(_value.copyWith(requestReview: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RequestReviewStateCopyWith<$Res>
    implements $RequestReviewStateCopyWith<$Res> {
  factory _$$_RequestReviewStateCopyWith(_$_RequestReviewState value,
          $Res Function(_$_RequestReviewState) then) =
      __$$_RequestReviewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RequestReview> requestReviews, RequestReview? requestReview});

  @override
  $RequestReviewCopyWith<$Res>? get requestReview;
}

/// @nodoc
class __$$_RequestReviewStateCopyWithImpl<$Res>
    extends _$RequestReviewStateCopyWithImpl<$Res, _$_RequestReviewState>
    implements _$$_RequestReviewStateCopyWith<$Res> {
  __$$_RequestReviewStateCopyWithImpl(
      _$_RequestReviewState _value, $Res Function(_$_RequestReviewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestReviews = null,
    Object? requestReview = freezed,
  }) {
    return _then(_$_RequestReviewState(
      requestReviews: null == requestReviews
          ? _value._requestReviews
          : requestReviews // ignore: cast_nullable_to_non_nullable
              as List<RequestReview>,
      requestReview: freezed == requestReview
          ? _value.requestReview
          : requestReview // ignore: cast_nullable_to_non_nullable
              as RequestReview?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestReviewState implements _RequestReviewState {
  _$_RequestReviewState(
      {final List<RequestReview> requestReviews = const [], this.requestReview})
      : _requestReviews = requestReviews;

  factory _$_RequestReviewState.fromJson(Map<String, dynamic> json) =>
      _$$_RequestReviewStateFromJson(json);

  final List<RequestReview> _requestReviews;
  @override
  @JsonKey()
  List<RequestReview> get requestReviews {
    if (_requestReviews is EqualUnmodifiableListView) return _requestReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestReviews);
  }

  @override
  final RequestReview? requestReview;

  @override
  String toString() {
    return 'RequestReviewState(requestReviews: $requestReviews, requestReview: $requestReview)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestReviewState &&
            const DeepCollectionEquality()
                .equals(other._requestReviews, _requestReviews) &&
            (identical(other.requestReview, requestReview) ||
                other.requestReview == requestReview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_requestReviews), requestReview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestReviewStateCopyWith<_$_RequestReviewState> get copyWith =>
      __$$_RequestReviewStateCopyWithImpl<_$_RequestReviewState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestReviewStateToJson(
      this,
    );
  }
}

abstract class _RequestReviewState implements RequestReviewState {
  factory _RequestReviewState(
      {final List<RequestReview> requestReviews,
      final RequestReview? requestReview}) = _$_RequestReviewState;

  factory _RequestReviewState.fromJson(Map<String, dynamic> json) =
      _$_RequestReviewState.fromJson;

  @override
  List<RequestReview> get requestReviews;
  @override
  RequestReview? get requestReview;
  @override
  @JsonKey(ignore: true)
  _$$_RequestReviewStateCopyWith<_$_RequestReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}
