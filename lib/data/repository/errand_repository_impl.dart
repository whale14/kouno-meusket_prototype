import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/request/request_recruitment.dart';
import 'package:test_project/domain/model/request/waypoint.dart';
import 'package:test_project/domain/repository/errand_repository.dart';

class ErrandRepositoryImpl implements ErrandRepository {
  ErrandApi api;

  ErrandRepositoryImpl(this.api);

  @override
  Future<List<Request>> getRequests(String idx) async {
    final response = await api.getRequests(idx);
    Logger().d(response.body);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Request.fromJson(e)).toList();
  }

  @override
  Future acceptRequest(String idx, String workerIdx) async{
    // TODO: implement acceptRequest
    await api.acceptRequest(idx, workerIdx);
  }

  @override
  Future<List<Request>> getMyRequestsRequesterSide(String idx) async{
    // TODO: implement getMyRequests
    final response = await api.getMyRequestsRequesterSide(idx);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Request.fromJson(e)).toList();
  }

  @override
  Future<List<Request>> getMyRequestsWorkerSide(String idx) async{
    // TODO: implement getMyRequestsWorkerSide
    final response = await api.getMyRequestsWorkerSide(idx);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Request.fromJson(e)).toList();  }

  @override
  Future<String> createChatRoom(String reqIdx) async{
    // TODO: implement createChatRoom
    final result = await api.createChatRoom(reqIdx);
    return result;
  }

  @override
  Future startRequest(String idx) async{
    // TODO: implement startRequest
    await api.startRequest(idx);
  }

  @override
  Future requestComplete(String idx) async{
    // TODO: implement requestComplete
    await api.requestComplete(idx);
  }

  @override
  Future<List<RequestRecruitment>> getRecruitments(String idx) async{
    // TODO: implement getRecruitments
    final response = await api.getRecruitments(idx);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => RequestRecruitment.fromJson(e)).toList();
  }

  @override
  Future rejectApplication(String idx) async{
    // TODO: implement rejectApplication
    await api.rejectApplication(idx);
  }

  @override
  Future acceptApplication(String reqIdx, String workerIdx) async{
    // TODO: implement acceptApplication
    await api.acceptApplication(reqIdx, workerIdx);
  }

  @override
  Future<Request> getRequest(String idx) async{
    // TODO: implement getRequest
    final response = await api.getRequest(idx);
    Logger().d("id : $idx, getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return Request.fromJson(json.first);
  }

  @override
  Future finishRequest(String idx) async{
    // TODO: implement finishRequest
    await api.finishRequest(idx);
  }

  @override
  Future recruitmentRequest(String idx, String workerIdx) async{
    // TODO: implement recruitmentRequest
    await api.recruitmentRequest(idx, workerIdx);
  }

  @override
  Future crateRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) async{
    // TODO: implement crateRequestReview
    await api.crateRequestReview(reqIdx, fromIdx, toIdx, score, comment);
  }

  @override
  Future<List<Waypoint>> getWaypoint(String idx) async{
    // TODO: implement getWaypoint
    final response = await api.getWaypoint(idx);
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Waypoint.fromJson(e)).toList();
  }

  @override
  Future requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequester) async{
    // TODO: implement requestCancel
    await api.requestCancel(requestIdx, content, requestStatus, userIdx, isRequester);
  }

  @override
  Future successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) async{
    // TODO: implement successCheckConfirm
    await api.successCheckConfirm(requestIdx, requesterIdx, workerIdx, reward);
  }

}
