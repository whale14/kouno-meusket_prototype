import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/request/request_recruitment.dart';

part 'request_recruitment_state.freezed.dart';

part 'request_recruitment_state.g.dart';

@freezed
class RequestRecruitmentState with _$RequestRecruitmentState {
  factory RequestRecruitmentState({
    @Default([]) List<RequestRecruitment> recruitments,
  }) = _RequestRecruitmentState;

  factory RequestRecruitmentState.fromJson(Map<String, dynamic> json) => _$RequestRecruitmentStateFromJson(json);
}