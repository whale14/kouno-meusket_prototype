// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestReview _$RequestReviewFromJson(Map<String, dynamic> json) {
  return _RequestReview.fromJson(json);
}

/// @nodoc
mixin _$RequestReview {
  int get idx => throw _privateConstructorUsedError;
  int get requestIdx => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  int get toIdx => throw _privateConstructorUsedError;
  int get isRequester => throw _privateConstructorUsedError;
  String? get reviewerImageUrl => throw _privateConstructorUsedError;
  String get reviewerName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestReviewCopyWith<RequestReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestReviewCopyWith<$Res> {
  factory $RequestReviewCopyWith(
          RequestReview value, $Res Function(RequestReview) then) =
      _$RequestReviewCopyWithImpl<$Res, RequestReview>;
  @useResult
  $Res call(
      {int idx,
      int requestIdx,
      double score,
      String comment,
      int toIdx,
      int isRequester,
      String? reviewerImageUrl,
      String reviewerName});
}

/// @nodoc
class _$RequestReviewCopyWithImpl<$Res, $Val extends RequestReview>
    implements $RequestReviewCopyWith<$Res> {
  _$RequestReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? score = null,
    Object? comment = null,
    Object? toIdx = null,
    Object? isRequester = null,
    Object? reviewerImageUrl = freezed,
    Object? reviewerName = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      toIdx: null == toIdx
          ? _value.toIdx
          : toIdx // ignore: cast_nullable_to_non_nullable
              as int,
      isRequester: null == isRequester
          ? _value.isRequester
          : isRequester // ignore: cast_nullable_to_non_nullable
              as int,
      reviewerImageUrl: freezed == reviewerImageUrl
          ? _value.reviewerImageUrl
          : reviewerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerName: null == reviewerName
          ? _value.reviewerName
          : reviewerName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RequestReviewCopyWith<$Res>
    implements $RequestReviewCopyWith<$Res> {
  factory _$$_RequestReviewCopyWith(
          _$_RequestReview value, $Res Function(_$_RequestReview) then) =
      __$$_RequestReviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      int requestIdx,
      double score,
      String comment,
      int toIdx,
      int isRequester,
      String? reviewerImageUrl,
      String reviewerName});
}

/// @nodoc
class __$$_RequestReviewCopyWithImpl<$Res>
    extends _$RequestReviewCopyWithImpl<$Res, _$_RequestReview>
    implements _$$_RequestReviewCopyWith<$Res> {
  __$$_RequestReviewCopyWithImpl(
      _$_RequestReview _value, $Res Function(_$_RequestReview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? score = null,
    Object? comment = null,
    Object? toIdx = null,
    Object? isRequester = null,
    Object? reviewerImageUrl = freezed,
    Object? reviewerName = null,
  }) {
    return _then(_$_RequestReview(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      toIdx: null == toIdx
          ? _value.toIdx
          : toIdx // ignore: cast_nullable_to_non_nullable
              as int,
      isRequester: null == isRequester
          ? _value.isRequester
          : isRequester // ignore: cast_nullable_to_non_nullable
              as int,
      reviewerImageUrl: freezed == reviewerImageUrl
          ? _value.reviewerImageUrl
          : reviewerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerName: null == reviewerName
          ? _value.reviewerName
          : reviewerName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestReview implements _RequestReview {
  _$_RequestReview(
      {required this.idx,
      required this.requestIdx,
      required this.score,
      required this.comment,
      required this.toIdx,
      required this.isRequester,
      required this.reviewerImageUrl,
      required this.reviewerName});

  factory _$_RequestReview.fromJson(Map<String, dynamic> json) =>
      _$$_RequestReviewFromJson(json);

  @override
  final int idx;
  @override
  final int requestIdx;
  @override
  final double score;
  @override
  final String comment;
  @override
  final int toIdx;
  @override
  final int isRequester;
  @override
  final String? reviewerImageUrl;
  @override
  final String reviewerName;

  @override
  String toString() {
    return 'RequestReview(idx: $idx, requestIdx: $requestIdx, score: $score, comment: $comment, toIdx: $toIdx, isRequester: $isRequester, reviewerImageUrl: $reviewerImageUrl, reviewerName: $reviewerName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestReview &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.requestIdx, requestIdx) ||
                other.requestIdx == requestIdx) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.toIdx, toIdx) || other.toIdx == toIdx) &&
            (identical(other.isRequester, isRequester) ||
                other.isRequester == isRequester) &&
            (identical(other.reviewerImageUrl, reviewerImageUrl) ||
                other.reviewerImageUrl == reviewerImageUrl) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idx, requestIdx, score, comment,
      toIdx, isRequester, reviewerImageUrl, reviewerName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestReviewCopyWith<_$_RequestReview> get copyWith =>
      __$$_RequestReviewCopyWithImpl<_$_RequestReview>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestReviewToJson(
      this,
    );
  }
}

abstract class _RequestReview implements RequestReview {
  factory _RequestReview(
      {required final int idx,
      required final int requestIdx,
      required final double score,
      required final String comment,
      required final int toIdx,
      required final int isRequester,
      required final String? reviewerImageUrl,
      required final String reviewerName}) = _$_RequestReview;

  factory _RequestReview.fromJson(Map<String, dynamic> json) =
      _$_RequestReview.fromJson;

  @override
  int get idx;
  @override
  int get requestIdx;
  @override
  double get score;
  @override
  String get comment;
  @override
  int get toIdx;
  @override
  int get isRequester;
  @override
  String? get reviewerImageUrl;
  @override
  String get reviewerName;
  @override
  @JsonKey(ignore: true)
  _$$_RequestReviewCopyWith<_$_RequestReview> get copyWith =>
      throw _privateConstructorUsedError;
}
