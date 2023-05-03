import 'dart:convert';

import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/repository/errand_repository.dart';

class ErrandRepositoryImpl implements ErrandRepository {
  ErrandApi api;

  ErrandRepositoryImpl(this.api);

  @override
  Future<List<Request>> getRequests(String idx) async {
    final response = await api.getRequests(idx);
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

}
