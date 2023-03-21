import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/users/users.dart';

abstract class ErrandRepository {
  Future<List<Users>> getUser(String id);

  Future<List<Users>> getAroundHelpers();

  Future insert(String id, String name, double latitude, double longitude);

  Future<String> getMyIdx(String id);

  Future insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude);

  Future<List<Request>> getRequests(String idx);

  Future<List<Request>> getMyRequestsRequesterSide(String idx);

  Future<List<Request>> getMyRequestsWorkerSide(String idx);

  Future acceptRequest(String idx, String workerIdx);

  Future updateLocation(String idx, double latitude, double longitude);
}