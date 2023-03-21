import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request.freezed.dart';

part 'request.g.dart';

@freezed
class Request with _$Request {
  factory Request({
    required int idx,
    required int requesterIdx,
    required int workerIdx,
    required int workCategoryIdx,
    required String title,
    required String content,
    required String address,
    required double latitude,
    required double longitude,
    required int status,
    required String regDate,
    required int reward,
  }) = _Request;

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
}