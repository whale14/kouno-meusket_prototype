import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_recruitment_state.dart';
import 'package:test_project/presentation/state/request/waypoint_state.dart';

import '../../domain/repository/errand_repository.dart';
import '../state/request/request_state.dart';

class RequestViewModel with ChangeNotifier {
  final ErrandRepository _errandRepository;
  var _requestState = RequestState();
  var _recruitmentState = RequestRecruitmentState();
  var _waypointsState = WaypointState();

  RequestState get requestState => _requestState;
  RequestRecruitmentState get recruitmentState => _recruitmentState;
  WaypointState get waypointState => _waypointsState;

  RequestViewModel(this._errandRepository) {
    // _getRequests();
  }

  Future onRequestEvent(RequestEvent event) async {

    switch (event) {
      case GetRequests(): _getRequests(event.idx);

    case AcceptRequest(): _acceptRequest(event.idx, event.workerIdx);
    case GetMyRequestsRequesterSide(): _getMyRequestsRequesterSide(event.idx);
    case GetMyRequestsWorkerSide(): _getMyRequestsWorkerSide(event.idx);
    case StartRequest(): _startRequest(event.idx);
    case RequestComplete():  _requestComplete(event.idx);
    case GetRecruitments(): _getRecruitments(event.idx);
    case RejectApplication(): _rejectApplication(event.idx);
    case AcceptApplication(): _acceptApplication(event.idx, event.workerIdx);
    case GetRequest(): _getRequest(event.idx);
    case FinishRequest(): _finishRequest(event.idx);
    case RecruitmentRequest(): _recruitmentRequest(event.idx, event.workerIdx);
    case CreateRequestReview(): _createRequestReview(event.idx, event.fromIdx, event.toIdx, event.score, event.comment);
    case GetWaypoints(): _getWaypoints(event.idx);
    case RequestCancel(): _requestCancel(event.requestIdx, event.content, event.requestStatus, event.userIdx, event.isRequest);
    case SuccessCheckConfirm(): _successCheckConfirm(event.requestIdx, event.requesterIdx, event.workerIdx, event.reward);
    }
  }

  Future _getMyRequestsRequesterSide(String idx) async {
    final result = _errandRepository.getMyRequestsRequesterSide(idx);

    _requestState = requestState.copyWith(requests: await result);
    notifyListeners();
  }

  Future _getMyRequestsWorkerSide(String idx) async {
    final result = _errandRepository.getMyRequestsWorkerSide(idx);

    _requestState = requestState.copyWith(requests: await result);
    notifyListeners();
    Logger().d("workerside>>>${await result}");
  }

  Future _acceptRequest(String idx, String workerIdx) async {
    await _errandRepository.acceptRequest(idx, workerIdx);
    await _getRequest(idx);
    // String roomIdx = await _errandRepository.createChatRoom(idx);
  }

  Future _getRequests(String idx) async {
    final result = _errandRepository.getRequests(idx);
    final _result = await result;
    Logger().d("!!!!!!!!!!!!!logger $_result");
    _requestState = requestState.copyWith(
      requests: _result,
    );
    notifyListeners();
  }

  Future _startRequest(String idx) async {
    await _errandRepository.startRequest(idx);
    await _getRequest(idx);
  }

  Future _requestComplete(String idx) async{
    await _errandRepository.requestComplete(idx);
  }

  Future _getRecruitments(String idx) async{
    final result = _errandRepository.getRecruitments(idx);

    _recruitmentState = recruitmentState.copyWith(
      recruitments: await result,
    );
    notifyListeners();
  }

  Future _rejectApplication(String idx) async{
    await _errandRepository.rejectApplication(idx);

  }

  Future _acceptApplication(String reqIdx, String workerIdx) async{
    await _errandRepository.acceptApplication(reqIdx, workerIdx);
    await _getRequest(reqIdx);
  }

  Future _getRequest(String idx) async{
    final result = _errandRepository.getRequest(idx);
    Logger().d("req viewModel getRequest : ${result.toString()}");
    _requestState = requestState.copyWith(
      request: await result,
    );
    notifyListeners();
  }


  Future _finishRequest(String idx) async{
    await _errandRepository.finishRequest(idx);
    await _getRequest(idx);
  }

  Future _recruitmentRequest(String idx, String workerIdx) async{
    await _errandRepository.recruitmentRequest(idx, workerIdx);
  }

  Future _createRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) async{
    await _errandRepository.crateRequestReview(reqIdx, fromIdx, toIdx, score, comment);
  }

  Future _getWaypoints(String idx) async{
    final result = _errandRepository.getWaypoint(idx);

    _waypointsState = waypointState.copyWith(
      waypoints: await result,
    );
    notifyListeners();
  }

  Future _requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequester) async{
    await _errandRepository.requestCancel(requestIdx, content, requestStatus, userIdx, isRequester);
  }

  Future _successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) async{
    await _errandRepository.successCheckConfirm(requestIdx, requesterIdx, workerIdx, reward);
    await _getRequest(requestIdx);
  }
}