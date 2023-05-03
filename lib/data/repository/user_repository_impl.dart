import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/user_api.dart';
import 'package:test_project/domain/model/user/users.dart';
import 'package:test_project/domain/repository/user_repository.dart';



class UserRepositoryImpl implements UserRepository {
  UserAPI api;

  UserRepositoryImpl(this.api);

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
  Future<Users> getUser(String id) async {
    // TODO: implement getAroundHelpers
    final response = await api.getUser(id);
    Logger().d("id : $id, getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return Users.fromJson(json.first);
  }

  @override
  Future updateLocation(String idx, double latitude, double longitude) async{
    // TODO: implement updateLocation
    await api.updateLocation(idx, latitude, longitude);
  }

  @override
  Future requestRegistration(String idx) async{
    // TODO: implement requestRegistration
    await api.requestRegistration(idx);
  }

  @override
  Future getUserFromIdx(String idx) async{
    // TODO: implement getUserFromIdx
    final response = await api.getUserFromIdx(idx);
    Logger().d("id : $idx, getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return Users.fromJson(json.first);
  }

  @override
  Future workerRegistration(String idx) async{
    // TODO: implement workerRegistration
    await api.workerRegistration(idx);
  }
}