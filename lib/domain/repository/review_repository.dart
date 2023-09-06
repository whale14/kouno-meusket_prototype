import 'package:test_project/domain/model/request/request_review.dart';

abstract class ReviewRepository {
  Future<List<RequestReview>> getReviews(String toIdx);
}