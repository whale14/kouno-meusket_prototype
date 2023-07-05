// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestReview _$$_RequestReviewFromJson(Map<String, dynamic> json) =>
    _$_RequestReview(
      idx: json['idx'] as int,
      requestIdx: json['requestIdx'] as int,
      score: (json['score'] as num).toDouble(),
      comment: json['comment'] as String,
      toIdx: json['toIdx'] as int,
      isRequester: json['isRequester'] as int,
    );

Map<String, dynamic> _$$_RequestReviewToJson(_$_RequestReview instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'requestIdx': instance.requestIdx,
      'score': instance.score,
      'comment': instance.comment,
      'toIdx': instance.toIdx,
      'isRequester': instance.isRequester,
    };
