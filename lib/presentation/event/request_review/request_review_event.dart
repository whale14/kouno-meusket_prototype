sealed class RequestReviewEvent<T> {
  factory RequestReviewEvent.getReviews(String toIdx)= GetReviews;

}

class GetReviews<T> implements RequestReviewEvent<T> {
  final String toIdx;

  GetReviews(this.toIdx);
}