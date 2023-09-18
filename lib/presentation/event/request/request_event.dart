// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'request_event.freezed.dart';
//
// @freezed
// abstract class RequestEvent<T> with _$RequestEvent<T> {
//   const factory RequestEvent.getRequests(String idx) = GetRequests;
//   const factory RequestEvent.getMyRequestsRequesterSide(String idx) = GetMyRequestsRequesterSide;
//   const factory RequestEvent.getMyRequestsWorkerSide(String idx) = GetMyRequestsWorkerSide;
//   const factory RequestEvent.acceptRequest(String idx, String workerIdx) = AccpetRequest;
//   const factory RequestEvent.startRequest(String idx) = StartRequest;
//   const factory RequestEvent.requestComplete(String idx) = RequestComplete;
//   const factory RequestEvent.getRecruitments(String idx) = GetRecruitments;
//   const factory RequestEvent.rejectApplication(String idx) = RejectApplication;
//   const factory RequestEvent.acceptApplication(String reqIdx, String workerIdx) = AcceptApplication;
//   const factory RequestEvent.getRequest(String idx) = GetRequest;
//   const factory RequestEvent.finishRequest(String idx) = FinishRequest;
//   const factory RequestEvent.recruitmentRequest(String idx, String workerIdx) = RecruitmentRequest;
//   const factory RequestEvent.createRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) = createRequestReview;
//   const factory RequestEvent.getWaypoints(String idx) = GetWaypoints;
//   const factory RequestEvent.requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequest) = RequestCancel;
//   const factory RequestEvent.successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) = SuccessCheckConfirm;
// }

sealed class RequestEvent<T> {
  factory RequestEvent.getRequests(String idx) = GetRequests;

  factory RequestEvent.getMyRequestsRequesterSide(String idx) = GetMyRequestsRequesterSide;

  factory RequestEvent.getMyRequestsWorkerSide(String idx) = GetMyRequestsWorkerSide;

  factory RequestEvent.acceptRequest(String idx, String workerIdx) = AcceptRequest;

  factory RequestEvent.startRequest(String idx) = StartRequest;

  factory RequestEvent.requestComplete(String idx) = RequestComplete;

  factory RequestEvent.getRecruitments(String idx) = GetRecruitments;

  factory RequestEvent.rejectApplication(String idx) = RejectApplication;

  factory RequestEvent.acceptApplication(String reqIdx, String workerIdx) = AcceptApplication;

  factory RequestEvent.getRequest(String idx) = GetRequest;

  factory RequestEvent.finishRequest(String idx) = FinishRequest;

  factory RequestEvent.recruitmentRequest(String idx, String workerIdx) = RecruitmentRequest;

  factory RequestEvent.createRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) = CreateRequestReview;

  factory RequestEvent.getWaypoints(String idx) = GetWaypoints;

  factory RequestEvent.requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequest) = RequestCancel;

  factory RequestEvent.successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) = SuccessCheckConfirm;
}

class GetRequests<T> implements RequestEvent<T> {
  final String idx;

  GetRequests(this.idx);
}

class GetMyRequestsRequesterSide<T> implements RequestEvent<T> {
  final String idx;

  GetMyRequestsRequesterSide(this.idx);
}

class GetMyRequestsWorkerSide<T> implements RequestEvent<T> {
  final String idx;

  GetMyRequestsWorkerSide(this.idx);
}

class AcceptRequest<T> implements RequestEvent<T> {
  final String idx;
  final String workerIdx;

  AcceptRequest(this.idx, this.workerIdx);
}

class StartRequest<T> implements RequestEvent<T> {
  final String idx;

  StartRequest(this.idx);
}

class RequestComplete<T> implements RequestEvent<T> {
  final String idx;

  RequestComplete(this.idx);
}

class GetRecruitments<T> implements RequestEvent<T> {
  final String idx;

  GetRecruitments(this.idx);
}

class RejectApplication<T> implements RequestEvent<T> {
  final String idx;

  RejectApplication(this.idx);
}

class AcceptApplication<T> implements RequestEvent<T> {
  final String idx;
  final String workerIdx;

  AcceptApplication(this.idx, this.workerIdx);
}

class GetRequest<T> implements RequestEvent<T> {
  final String idx;

  GetRequest(this.idx);
}

class FinishRequest<T> implements RequestEvent<T> {
  final String idx;

  FinishRequest(this.idx);
}

class RecruitmentRequest<T> implements RequestEvent<T> {
  final String idx;
  final String workerIdx;

  RecruitmentRequest(this.idx, this.workerIdx);
}

class CreateRequestReview<T> implements RequestEvent<T> {
  final String idx;
  final String fromIdx;
  final String toIdx;
  final double score;
  final String comment;

  CreateRequestReview(this.idx, this.fromIdx, this.toIdx, this.score, this.comment);
}

class GetWaypoints<T> implements RequestEvent<T> {
  final String idx;

  GetWaypoints(this.idx);
}

class RequestCancel<T> implements RequestEvent<T> {
  final String requestIdx;
  final String content;
  final String requestStatus;
  final String userIdx;
  final String isRequest;

  RequestCancel(this.requestIdx, this.content, this.requestStatus, this.userIdx, this.isRequest);
}

class SuccessCheckConfirm<T> implements RequestEvent<T> {
  final String requestIdx;
  final String requesterIdx;
  final String workerIdx;
  final String reward;

  SuccessCheckConfirm(this.requestIdx, this.requesterIdx, this.workerIdx, this.reward);
}
