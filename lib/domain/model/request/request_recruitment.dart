import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_recruitment.freezed.dart';

part 'request_recruitment.g.dart';

@freezed
class RequestRecruitment with _$RequestRecruitment {
  factory RequestRecruitment({
    required int idx,
    required int requestIdx,
    required int userIdx,
    required int isRejected,
    required String workerName,
    required String workerImgUrl,
    required String transportation,
    required String workCategory,
  }) = _RequestRecruitment;

  factory RequestRecruitment.fromJson(Map<String, dynamic> json) => _$RequestRecruitmentFromJson(json);
}