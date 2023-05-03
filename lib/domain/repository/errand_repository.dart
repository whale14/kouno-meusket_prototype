import 'package:test_project/domain/model/request/request.dart';

abstract class ErrandRepository {

  Future<List<Request>> getRequests(String idx);

  Future<List<Request>> getMyRequestsRequesterSide(String idx);

  Future<List<Request>> getMyRequestsWorkerSide(String idx);

  Future acceptRequest(String idx, String workerIdx);


  Future<String> createChatRoom(String reqIdx);

}