import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_recruitment_state.dart';

import '../../domain/repository/errand_repository.dart';
import '../state/request/request_state.dart';

class RequestViewModel with ChangeNotifier {
  final ErrandRepository _errandRepository;
  var _requestState = RequestState();
  var _recruitmentState = RequestRecruitmentState();

  RequestState get requestState => _requestState;
  RequestRecruitmentState get recruitmentState => _recruitmentState;
  RequestViewModel(this._errandRepository) {
    // _getRequests();
  }

  Future onRequestEvent(RequestEvent event) async {
    await event.when(
      getRequests: _getRequests,
      acceptRequest: _acceptRequest,
      getMyRequestsRequesterSide: _getMyRequestsRequesterSide,
      getMyRequestsWorkerSide: _getMyRequestsWorkerSide,
      startRequest: _startRequest,
      requestComplete:  _requestComplete,
      getRecruitments: _getRecruitments,
      rejectApplication: _rejectApplication,
      acceptApplication: _acceptApplication,
      getRequest: _getRequest,
      finishRequest: _finishRequest,
      recruitmentRequest: _recruitmentRequest,
      createRequestReview: _createRequestReview,
    );
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
    // String roomIdx = await _errandRepository.createChatRoom(idx);
  }

  Future _getRequests(String idx) async {
    final result = _errandRepository.getRequests(idx);
    Logger().d("!!!!!!!!!!!!!logger");
    _requestState = requestState.copyWith(
      requests: await result,
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
}