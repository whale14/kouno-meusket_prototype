import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ErrandApi {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/errand';  //로컬 호스트
  // static const baseUrl = 'http://192.168.33.7:9001/errand';  //작업실
  // static const baseUrl = 'http://172.30.1.69:9001/errand';  //집
  // static const baseUrl = 'http://192.168.101.2:9001/errand'; //기기 사용 3층
  static const baseUrl = 'http://203.229.171.79:84/errand'; //기기 사용 5층
  // static const baseUrl = 'http://192.168.0.168:9001/errand'; //5층 소셜캠퍼스

  ErrandApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getRequests(String idx) async{
    Logger().d("getRequests ##### idx : $idx");
    String url = '$baseUrl/get_requests.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getMyRequestsRequesterSide(String idx) async{
    String url = '$baseUrl/get_my_requests_requester_side.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getMyRequestsWorkerSide(String idx) async{
    String url = '$baseUrl/get_my_requests_worker_side.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
    return response;
  }

  Future acceptRequest(String idx, String workerIdx) async{
    String url = '$baseUrl/accept_request.php';
    Map<String, dynamic> data = {
      'idx' : idx,
      'workerIdx' : workerIdx
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future recruitmentRequest(String idx, String workerIdx) async{
    String url = '$baseUrl/recruitment_request.php';
    Map<String, dynamic> data = {
      'idx' : idx,
      'workerIdx' : workerIdx
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future<String> createChatRoom(String reqIdx) async{
    String url = '$baseUrl/create_chat_room.php';
    Map<String, dynamic> data = {
      'reqIdx' : reqIdx
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
    return response.body;
  }

  Future startRequest(String idx) async{
    String url = '$baseUrl/start_request.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future requestComplete(String idx) async{
    String url = '$baseUrl/request_complete.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future getRecruitments(String idx) async{
    String url = '$baseUrl/get_recruitments.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
    return response;
  }

  Future rejectApplication(String idx) async{
    String url = '$baseUrl/reject_application.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future acceptApplication(String reqIdx, String workerIdx) async{
    String url = '$baseUrl/accept_application.php';
    Map<String, dynamic> data = {
      'idx' : reqIdx,
      'workerIdx' : workerIdx,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future getRequest(String idx) async{
    String url = '$baseUrl/get_request.php';
    Map<String, dynamic> data = {'idx': idx};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("id: $idx, request: ${response.body}");
    return response;
  }

  finishRequest(String idx) async{
    String url = '$baseUrl/finish_request.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future crateRequestReview(String reqIdx, String fromIdx, String toIdx, double score, String comment) async{
    String url = '$baseUrl/create_request_review.php';
    Map<String, dynamic> data = {
      'reqIdx' : reqIdx,
      'fromIdx' : fromIdx,
      'toIdx' : toIdx,
      'score' : score.toString(),
      'comment' : comment
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future<http.Response> getWaypoint(String idx) async{
    String url = '$baseUrl/get_waypoints.php';
    Map<String, dynamic> data = {
      'requestIdx' : idx,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future requestCancel(String requestIdx, String content, String requestStatus, String userIdx, String isRequester) async{
    String url = '$baseUrl/request_cancel.php';
    Map<String, dynamic> data = {
      'requestIdx' : requestIdx,
      'content' : content,
      'requestStatus' : requestStatus,
      'userIdx' : userIdx,
      'isRequester' : isRequester,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("requestCancel############ ${response.body}");
  }

  Future successCheckConfirm(String requestIdx, String requesterIdx, String workerIdx, String reward) async{
    String url = '$baseUrl/success_check_confirm.php';
    Map<String, dynamic> data = {
      'requestIdx' : requestIdx,
      'requesterIdx' : requesterIdx,
      'workerIdx' : workerIdx,
      'reward' : reward,
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("#############successCheckConfirm ${response.body}");
  }

}
