import 'package:test_project/domain/model/user/user.dart';

abstract class UserRepository {
  Future<User> getUser(String id);

  Future<List<User>> getAroundHelpers();

  Future updateLocation(String idx, double latitude, double longitude);

  Future insert(String id, String name, double latitude, double longitude);

  Future<String> getMyIdx(String id);

  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude);

  Future requestRegistration(String id);

  Future getUserFromIdx(String idx);

  Future workerRegistration(String idx);

  Future updateUserInfo(String idx, String fileName);
}