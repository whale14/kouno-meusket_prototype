import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_event.freezed.dart';

@freezed
abstract class RequestEvent<T> with _$RequestEvent<T> {
  const factory RequestEvent.getRequests(String idx) = GetRequests;
  const factory RequestEvent.getMyRequestsRequesterSide(String idx) = GetMyRequestsRequesterSide;
  const factory RequestEvent.getMyRequestsWorkerSide(String idx) = GetMyRequestsWorkerSide;
  const factory RequestEvent.acceptRequest(String idx, String workerIdx) = AccpetRequest;
  const factory RequestEvent.startRequest(String idx) = StartRequest;
  const factory RequestEvent.requestComplete(String idx) = RequestComplete;
  const factory RequestEvent.getRecruitments(String idx) = GetRecruitments;
  const factory RequestEvent.rejectApplication(String idx) = RejectApplication;
  const factory RequestEvent.acceptApplication(String reqIdx, String workerIdx) = AcceptApplication;
  const factory RequestEvent.getRequest(String idx) = GetRequest;
  const factory RequestEvent.finishRequest(String idx) = FinishRequest;
  const factory RequestEvent.recruitmentRequest(String idx, String workerIdx) = RecruitmentRequest;
  const factory RequestEvent.createRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) = createRequestReview;
  const factory RequestEvent.getWaypoints(String idx) = GetWaypoints;
  const factory RequestEvent.requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequest) = RequestCancel;
  const factory RequestEvent.successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) = SuccessCheckConfirm;
}