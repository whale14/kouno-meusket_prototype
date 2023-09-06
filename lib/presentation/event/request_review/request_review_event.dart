import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_review_event.freezed.dart';

@freezed
abstract class RequestReviewEvent<T> with _$RequestReviewEvent<T> {
  const factory RequestReviewEvent.getReviews(String toIdx)= GetReviews;
}