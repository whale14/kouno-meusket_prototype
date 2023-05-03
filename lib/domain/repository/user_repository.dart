import 'package:test_project/domain/model/user/users.dart';

abstract class UserRepository {
  Future<Users> getUser(String id);

  Future<List<Users>> getAroundHelpers();

  Future updateLocation(String idx, double latitude, double longitude);

  Future insert(String id, String name, double latitude, double longitude);

  Future<String> getMyIdx(String id);

  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude);

  Future requestRegistration(String id);

  Future getUserFromIdx(String idx);

  Future workerRegistration(String idx);
}