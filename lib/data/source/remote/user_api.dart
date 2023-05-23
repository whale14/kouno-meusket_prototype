import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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
      'id': id,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    return response;
  }

  Future<http.Response> getUser(String id) async {
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_user.php';
    Map<String, dynamic> data = {'id': id};
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

  Future<void> insert(String id, String name, double latitude, double longitude, String fcmToken) async {
    Logger().d("api data: $id, $name, ${latitude.toString()}, ${longitude.toString()}");
    String url = '$baseUrl/insert.php';
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'fcmToken': fcmToken,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future<void> insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude) async {
    String url = '$baseUrl/insert_request.php';
    Map<String, dynamic> data = {
      'reqIdx': reqIdx,
      'category': categoryIdx,
      'title': title,
      'content': content,
      'address': address,
      'latitude': latitude,
      'longitude': longitude
    };

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future updateLocation(String idx, double latitude, double longitude) async {
    String url = '$baseUrl/update_location.php';
    Map<String, dynamic> data = {'idx': idx, 'latitude': latitude.toString(), 'longitude': longitude.toString()};

    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
  }

  Future requestRegistration(String idx) async {
    String url = '$baseUrl/request_registration.php';
    Map<String, dynamic> data = {
      'idx': idx,
    };
    await _client.post(Uri.parse(url), body: data);
  }

  Future<http.Response> getUserFromIdx(String idx) async {
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_user_from_idx.php';
    Map<String, dynamic> data = {'idx': idx};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d("id: $idx, user: ${response.body}");
    return response;
  }

  Future workerRegistration(String idx) async {
    String url = '$baseUrl/worker_registration.php';
    Map<String, dynamic> data = {
      'idx': idx,
    };
    await _client.post(Uri.parse(url), body: data);
  }

  Future updateUserInfo(String idx, String fileName) async {
    String url = '$baseUrl/update_user_info.php';
    String imageUrl = '192.168.100.100:8080/static/$fileName';
    Map<String, dynamic> data = {'idx': idx, 'imageUrl': imageUrl};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future updateUserName(String idx, String name) async {
    String url = '$baseUrl/update_user_name.php';
    Map<String, dynamic> data = {'idx': idx, 'name': name};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future updateUserBio(String idx, String bio) async {
    String url = '$baseUrl/update_user_bio.php';
    Map<String, dynamic> data = {'idx': idx, 'bio': bio};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future updateUserIntroduce(String idx, String introduce) async {
    String url = '$baseUrl/update_user_introduce.php';
    Map<String, dynamic> data = {'idx': idx, 'introduce': introduce};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future updateUserTransportation(String idx, String transportation) async {
    String url = '$baseUrl/update_user_transportation.php';
    Map<String, dynamic> data = {'idx': idx, 'transportation': transportation};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future updateUserWorkCategory(String idx, String workCategory) async {
    String url = '$baseUrl/update_user_work_category.php';
    Map<String, dynamic> data = {'idx': idx, 'workCategory': workCategory};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs) async {
    final dio = Dio();
    dio.options.contentType = 'multipart/form-data';

    String idCardUrl = 'http://192.168.100.100:8080/upload_id_card';
    String faceCheckUrl = 'http://192.168.100.100:8080/uploadFaceCheck';

    Uint8List idCardImage = await File(idCardPath).readAsBytes();
    final idCardForm = FormData.fromMap({
      'file': MultipartFile.fromBytes(idCardImage, filename: "id_card$idx.png"),
    });

    Uint8List faceCheckImage = await File(faceCheckPath).readAsBytes();
    final faceCheckForm = FormData.fromMap({
      'file': MultipartFile.fromBytes(faceCheckImage, filename: "face_check$idx.png"),
    });

    await dio.post(idCardUrl, data: idCardForm);
    await dio.post(faceCheckUrl, data: faceCheckForm);

    String url = "$baseUrl/insert_worker_approval.php";

    for (String str in infs) {
      Logger().d(str);
    }

    Map<String, dynamic> data = {
      "idx": idx,
      "recognitionText": infs[0],
      "accountName": infs[1],
      "bankName": infs[2],
      "accountNumber": infs[3],
      "introduce": infs[4],
      "transportation": infs[5],
      "workCategory": infs[6],
    };
    final response = await _client.post(Uri.parse(url), body: data);

    Logger().d(response.body);
  }

  Future sendRequestToWorker(
      String reqIdx, String categoryIdx, String workerIdx, String title, String content, String address, String latitude, String longitude, String fcmToken) async {
    String url = '$baseUrl/send_request_to_worker.php';
    Map<String, dynamic> data = {
      'reqIdx': reqIdx,
      'workerIdx' : workerIdx,
      'category': categoryIdx,
      'title': title,
      'content': content,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };

    // final response = await _client.post(Uri.parse(url), body: data);
    // Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');

    try {
      Map fcmData = {
        "token": fcmToken,
        // "topic": "user_uid",

        "notification": {
          "title": "FCM Test Title",
          "body": "FCM Test Body",
        },
        "data": {
          "click_action": "FCM Test Click Action",
        },
        "android": {
          "notification": {
            "click_action": "Android Click Action",
          }
        },
        "apns": {
          "payload": {
            "aps": {"category": "Message Category", "content-available": "1"}
          }
        }
      };
      http.Response _response = await http.post(
        Uri.parse(
          "http://192.168.100.42:4000/sendFCM",
        ),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $_accessToken',
        },
        body: json.encode(fcmData),
      );
      if (_response.statusCode == 200) {
        Logger().d(_response.body);
      } else {
        Logger().d("fail.. >> ${_response.body}");
      }
    } on HttpException catch (error) {
      Logger().d(error.message);
    }
  }
}
