import 'package:test_project/domain/model/user/user.dart';

abstract class UserRepository {
  Future<User> getUser(String id);

  Future<List<User>> getAroundHelpers();

  Future updateLocation(String idx, double latitude, double longitude);

  Future insert(String id, String name, double latitude, double longitude, String fcmToken);

  Future<String> getMyIdx(String id);

  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, DateTime date, String runningTime, String reward);

  Future requestRegistration(String id);

  Future getUserFromIdx(String idx);

  Future workerRegistration(String idx);

  Future updateUserInfo(String idx, String fileName);

  Future updateUserName(String idx, String name);

  Future updateUserBio(String idx, String bio);

  Future updateUserIntroduce(String idx, String introduce);

  Future updateUserTransportation(String idx, String transportation);

  Future updateUserWorkCategory(String idx, String workCategory);

  Future workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs);

  Future sendRequestToWorker(String reqIdx, String workerIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String fcmToken);

  Future<bool> checkId(id);

  Future updateWorkableState(String idx);

  Future updateNotWorkableState(String idx);
}