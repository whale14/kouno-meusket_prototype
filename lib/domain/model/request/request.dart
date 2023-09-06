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
    required DateTime? workDate,
    required String? runningTime,
    required int status,
    required String regDate,
    required int reward,
    required String requesterName,
    required String workerName,
    required String? requesterImgUrl,
    required String? workerImgUrl,
    required int recruitmentStatus,
    required int? reviewRequesterIdx,
    required int? reviewWorkerIdx,
    required int successCheck,
    required int requestType,
    required int secondType,
    required int isReported,
  }) = _Request;

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
}