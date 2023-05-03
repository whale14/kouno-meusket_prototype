import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class UserAPI {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/user';  //로컬 호스트
  // static const baseUrl = 'http://192.168.101.2:9001/user'; //기기 사용 3층
  static const baseUrl = 'http://192.168.100.42:9001/user'; //기기 사용 5층

  UserAPI({http.Client? client}) : _client = (client ?? http.Client());

  //주변 헬퍼 위치 받아오기
  Future<http.Response> getMyIdx(String id) async {
    String url = '$baseUrl/get_my_idx.php';
    Map<String, dynamic> data = {
      'id':id,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getUser(String id) async {
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_user.php';
    Map<String, dynamic> data = {
      'id': id
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("id: $id, user: ${response.body}");
    return response;
  }

  Future<http.Response> getAroundHelpers() async {
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_around_helpers.php';
    // Map<String, dynamic> data = {
    //   'id': id
    // };
    final response = await _client.post(Uri.parse(url));
    Logger().d("api_get_AH_reponse: ${response.body}");
    return response;
  }

  Future<void> insert(String id, String name, double latitude, double longitude) async {
    Logger().d("api data: $id, $name, ${latitude.toString()}, ${longitude.toString()}");
    String url = '$baseUrl/insert.php';
    Map<String, dynamic> data = {
      'id':id,
      'name':name,
      'latitude':latitude.toString(),
      'longitude':longitude.toString()
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('${response.body}');
  }

  Future<void> insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude) async {
    String url = '$baseUrl/insert_request.php';
    Map<String, dynamic> data = {
      'reqIdx': reqIdx,
      'category': categoryIdx,
      'title': title,
      'content': content,
      'address': address,
      'latitude':latitude,
      'longitude':longitude
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future updateLocation(String idx, double latitude, double longitude) async{
    String url = '$baseUrl/update_location.php';
    Map<String, dynamic> data = {
      'idx' : idx,
      'latitude' : latitude.toString(),
      'longitude' : longitude.toString()
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future requestRegistration(String idx) async{
    String url = '$baseUrl/request_registration.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    await _client.post(Uri.parse(url), body: data);
  }

  Future<http.Response> getUserFromIdx(String idx) async{
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_user_from_idx.php';
    Map<String, dynamic> data = {
      'idx': idx
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("id: $idx, user: ${response.body}");
    return response;
  }

  Future workerRegistration(String idx) async{
    String url = '$baseUrl/worker_registration.php';
    Map<String, dynamic> data = {
      'idx' : idx,
    };
    await _client.post(Uri.parse(url), body: data);
  }

}