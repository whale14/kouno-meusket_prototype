import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/presentation/event/request/request_event.dart';

import '../../domain/repository/errand_repository.dart';
import '../state/request/request_state.dart';

class RequestViewModel with ChangeNotifier {
  final ErrandRepository _errandRepository;
  var _requestState = RequestState();

  RequestState get requestState => _requestState;

  RequestViewModel(this._errandRepository) {
    // _getRequests();
  }

  Future onRequestEvent(RequestEvent event) async{
    await event.when(getRequests: _getRequests, acceptRequest: _acceptRequest, getMyRequestsRequesterSide: _getMyRequestsRequesterSide, getMyRequestsWorkerSide: _getMyRequestsWorkerSide);
  }

  Future _getMyRequestsRequesterSide(String idx) async{
    final result = _errandRepository.getMyRequestsRequesterSide(idx);

    _requestState = requestState.copyWith(
      requests: await result
    );
    notifyListeners();
  }

  Future _getMyRequestsWorkerSide(String idx) async{
    final result = _errandRepository.getMyRequestsWorkerSide(idx);

    _requestState = requestState.copyWith(
        requests: await result
    );
    notifyListeners();
    Logger().d("workerside>>>${await result}");
  }

  Future _acceptRequest(String idx, String workerIdx) async{
    await _errandRepository.acceptRequest(idx, workerIdx);
  }

  Future _getRequests(String idx) async{
    final result = _errandRepository.getRequests(idx);

    _requestState = requestState.copyWith(
      requests: await result,
    );
    notifyListeners();
  }

}