import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:test_project/data/source/remote/user_api.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/domain/repository/user_repository.dart';



class UserRepositoryImpl implements UserRepository {
  UserAPI api;

  UserRepositoryImpl(this.api);

  @override
  Future<List<User>> getAroundHelpers() async {
    // TODO: implement getAroundHelpers
    final response = await api.getAroundHelpers();
    Logger().d("getAH_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => User.fromJson(e)).toList();
  }

  @override
  Future insert(String id, String name, double latitude, double longitude, String fcmToken) async {
    // TODO: implement insert
    Logger().d("repo data: $id, $name, $latitude, $longitude, $fcmToken");
    await api.insert(id, name, latitude, longitude, fcmToken);
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
  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, DateTime date, String runningTime, String reward) async {
    // TODO: implement insertRequest
    await api.insertRequest(reqIdx, categoryIdx, title, content, address, latitude, longitude, date, runningTime, reward);
  }

  @override
  Future<User> getUser(String id) async {
    // TODO: implement getAroundHelpers
    final response = await api.getUser(id);
    Logger().d("id : $id, getUser_repo_res:${response.body}");
    final Iterable json = jsonDecode(response.body);
    return User.fromJson(json.first);
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
    return User.fromJson(json.first);
  }

  @override
  Future workerRegistration(String idx) async{
    // TODO: implement workerRegistration
    await api.workerRegistration(idx);
  }

  @override
  Future updateUserInfo(String idx, String fileName) async{
    // TODO: implement updateUserInfo
    await api.updateUserInfo(idx, fileName);
  }

  @override
  Future updateUserName(String idx, String name) async{
    // TODO: implement updateUserName
    await api.updateUserName(idx, name);
  }

  @override
  Future updateUserBio(String idx, String bio) async{
    // TODO: implement updateUserBio
    await api.updateUserBio(idx, bio);
  }

  @override
  Future updateUserIntroduce(String idx, String introduce) async{
    // TODO: implement updateUserIntroduce
    await api.updateUserIntroduce(idx, introduce);
  }

  @override
  Future updateUserTransportation(String idx, String transportation) async{
    // TODO: implement updateUserTransportation
    await api.updateUserTransportation(idx, transportation);
  }

  @override
  Future updateUserWorkCategory(String idx, String workCategory) async{
    // TODO: implement updateUserWorkCategory
    await api.updateUserWorkCategory(idx, workCategory);
  }

  @override
  Future workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs) async{
    // TODO: implement workerRegistration1
    await api.workerRegistration1(idx, idCardPath, faceCheckPath, infs);
  }

  @override
  Future sendRequestToWorker(String reqIdx,String workerIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String fcmToken) async{
    // TODO: implement sendRequestToWorker
    await api.sendRequestToWorker(reqIdx, workerIdx, categoryIdx, title, content, address, latitude, longitude, fcmToken);
  }

  @override
  Future<bool> checkId(id) async{
    // TODO: implement checkId
    return await api.checkId(id);
  }

  @override
  Future updateWorkableState(String idx) async{
    // TODO: implement updateWorkableState
    await api.updateWorkableState(idx);
  }

  @override
  Future updateNotWorkableState(String idx) async{
    // TODO: implement updateNotWorkableState
    await api.updateNotWorkableState(idx);
  }
}