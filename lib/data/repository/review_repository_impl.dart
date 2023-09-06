import 'dart:convert';

import 'package:test_project/data/source/remote/review_api.dart';
import 'package:test_project/domain/model/request/request_review.dart';
import 'package:test_project/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewApi api;

  ReviewRepositoryImpl(this.api);

  @override
  Future<List<RequestReview>> getReviews(String toIdx) async{
    // TODO: implement getReviews
    final response = await api.getReviews(toIdx);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => RequestReview.fromJson(e)).toList();
  }


}