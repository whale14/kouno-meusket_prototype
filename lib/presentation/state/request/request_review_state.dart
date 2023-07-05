import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/request/request_review.dart';

part 'request_review_state.freezed.dart';

part 'request_review_state.g.dart';

@freezed
class RequestReviewState with _$RequestReviewState {
  factory RequestReviewState({
    @Default([]) List<RequestReview> requestReviews,
    RequestReview? requestReview,
  }) = _RequestReviewState;

  factory RequestReviewState.fromJson(Map<String, dynamic> json) => _$RequestReviewStateFromJson(json);
}