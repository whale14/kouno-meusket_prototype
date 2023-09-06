import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/request/request_recruitment.dart';

abstract class ErrandRepository {

  Future<List<Request>> getRequests(String idx);

  Future<List<Request>> getMyRequestsRequesterSide(String idx);

  Future<List<Request>> getMyRequestsWorkerSide(String idx);

  Future acceptRequest(String idx, String workerIdx);


  Future<String> createChatRoom(String reqIdx);

  Future startRequest(String idx);

  Future requestComplete(String idx);

  Future<List<RequestRecruitment>> getRecruitments(String idx);

  Future rejectApplication(String idx);

  Future acceptApplication(String reqIdx, String workerIdx);

  Future<Request> getRequest(String idx);

  Future finishRequest(String idx);

  Future recruitmentRequest(String idx, String workerIdx);

  Future crateRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment);

  Future getWaypoint(String idx);

  Future requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequester);

  Future successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward);

}