import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ErrandApi {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/errand';  //로컬 호스트
  // static const baseUrl = 'http://192.168.101.2:9001/errand'; //기기 사용 3층
  static const baseUrl = 'http://192.168.100.42:9001/errand'; //기기 사용 5층

  ErrandApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getRequests(String idx) async{
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

  Future<String> createChatRoom(String reqIdx) async{
    String url = '$baseUrl/create_chat_room.php';
    Map<String, dynamic> data = {
      'reqIdx' : reqIdx
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
    return response.body;
  }

}
