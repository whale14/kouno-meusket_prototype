import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_review.freezed.dart';

part 'request_review.g.dart';

@freezed
class RequestReview with _$RequestReview {
  factory RequestReview({
    required int idx,
    required int requestIdx,
    required double score,
    required String comment,
    required int toIdx,
    required int isRequester,
  }) = _RequestReview;

  factory RequestReview.fromJson(Map<String, dynamic> json) => _$RequestReviewFromJson(json);
}