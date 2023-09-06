import 'package:flutter/material.dart';
import 'package:test_project/domain/repository/review_repository.dart';
import 'package:test_project/presentation/event/request_review/request_review_event.dart';
import 'package:test_project/presentation/state/request/request_review_state.dart';

class ReviewViewModel with ChangeNotifier {
  final ReviewRepository _reviewRepository;
  var _reviewState = RequestReviewState();

  RequestReviewState get reviewState => _reviewState;

  ReviewViewModel(this._reviewRepository);

  Future onReviewEvent(RequestReviewEvent event) async {
    await event.when(
      getReviews: _getReviews,
    );
  }

  Future _getReviews(String toIdx) async{
    final result = _reviewRepository.getReviews(toIdx);
    _reviewState = reviewState.copyWith(
      requestReviews: await result,
    );
    notifyListeners();
  }
}
