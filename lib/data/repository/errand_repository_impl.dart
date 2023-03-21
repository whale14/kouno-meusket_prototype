import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/users/users.dart';
import 'package:test_project/domain/repository/errand_repository.dart';

class ErrandRepositoryImpl implements ErrandRepository {
  ErrandApi api;

  ErrandRepositoryImpl(this.api);

  @override
  Future<List<Users>> getAroundHelpers() async {
    // TODO: implement getAroundHelpers
    final response = await api.getAroundHelpers();
    Logger().d("getAH_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Users.fromJson(e)).toList();
  }

  @override
  Future insert(String id, String name, double latitude, double longitude) async {
    // TODO: implement insert
    Logger().d("repo data: $id, $name, $latitude, $longitude");
    await api.insert(id, name, latitude, longitude);
  }

  @override
  Future<String> getMyIdx(String id) async {
    // TODO: implement getMyIdx
    final response = await api.getMyIdx(id);
    final Iterable json = jsonDecode(response.body);
    Logger().d(json.first['idx']);

    return json.first['idx'].toString();
  }

  @override
  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude) async {
    // TODO: implement insertRequest
    await api.insertRequest(reqIdx, categoryIdx, title, content, address, latitude, longitude);
  }

  @override
  Future<List<Users>> getUser(String id) async {
    // TODO: implement getAroundHelpers
    final response = await api.getUser(id);
    Logger().d("getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Users.fromJson(e)).toList();
  }

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
  Future updateLocation(String idx, double latitude, double longitude) async{
    // TODO: implement updateLocation
    await api.updateLocation(idx, latitude, longitude);
  }

  @override
  Future<String> createChatRoom(String reqIdx) async{
    // TODO: implement createChatRoom
    final result = await api.createChatRoom(reqIdx);
    return result;
  }

}
