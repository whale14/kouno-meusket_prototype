// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_review_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestReviewState _$$_RequestReviewStateFromJson(
        Map<String, dynamic> json) =>
    _$_RequestReviewState(
      requestReviews: (json['requestReviews'] as List<dynamic>?)
              ?.map((e) => RequestReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requestReview: json['requestReview'] == null
          ? null
          : RequestReview.fromJson(
              json['requestReview'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RequestReviewStateToJson(
        _$_RequestReviewState instance) =>
    <String, dynamic>{
      'requestReviews': instance.requestReviews,
      'requestReview': instance.requestReview,
    };
