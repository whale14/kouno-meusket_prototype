import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_project/domain/model/work_category.dart';

class UserAPI {
  final http.Client _client;

  // static const baseUrl = 'http://10.0.2.2:9001/user';  //로컬 호스트
  // static const baseUrl = 'http://192.168.33.7:9001/user';  //작업실
  // static const baseUrl = 'http://172.30.1.69:9001/user';  //집
  // static const baseUrl = 'http://192.168.101.2:9001/user'; //기기 사용 3층
  // static const baseUrl = 'http://192.168.100.42:9001/user'; //기기 사용 5층
  static const baseUrl = 'http://203.229.171.79:84/user'; //기기 사용 5층
  // static const baseUrl = 'http://192.168.0.168:9001/user'; //5층 소셜캠퍼스

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

  Future<http.Response> getAroundHelpers(
      String idx, List<bool> categoryCheckValues, List<bool> ageCheckValues, List<bool> genderCheckValues, int distance) async {
    // Logger().d("api_getAH_data : ");
    String url = '$baseUrl/get_around_helpers.php';

    List<String> categories = WorkCategory().categories;
    categories.add('전체 서비스');
    String category = '';
    String ageGroup = '';
    String gender = '';
    List<int> indexList = [];
    for (int i = 0; i < categoryCheckValues.length; i++) {
      if (categoryCheckValues[i]) {
        indexList.add(i);
      }
    }
    Logger().d('#################categoryIndexList : $indexList');
    for (int i = 0; i < indexList.length; i++) {
      int index = indexList[i];
      if (i == indexList.length - 1) {
        category += categories[index];
      } else {
        category += '${categories[index]},';
      }
    }
    indexList = [];
    for (int i = 0; i < ageCheckValues.length; i++) {
      if (ageCheckValues[i]) {
        indexList.add(i);
      }
    }
    Logger().d('##########ageIndexList : $indexList');
    for (int i = 0; i < indexList.length; i++) {
      int index = indexList[i];
      if (i == indexList.length - 1) {
        ageGroup += ['', '20대', '30대', '40대', '50대', '60대 이상'][index];
      } else {
        ageGroup += '${['', '20대', '30대', '40대', '50대', '60대 이상'][index]},';
      }
    }

    for (int i = 0; i < genderCheckValues.length; i++) {
      if (genderCheckValues[i]) {
        gender = ['', '남성', '여성'][i];
      }
    }
    Map<String, dynamic> data = {
      'idx': idx,
      'categories': category,
      'ageGroup': ageGroup,
      'gender': gender,
      'distance': distance.toString(),
    };
    Logger().d("api_get_AH_categoryValue: $categoryCheckValues");
    Logger().d("api_get_AH_query: $category, $ageGroup, $gender, $distance");
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(
      "api_get_AH_reponse: ${response.body}",
    );
    return response;
    // Logger().d("api_get_AH_reponse: ${response.body}",);
    // return response;
  }

  Future<void> insert(String id, String name, String bio, double latitude, double longitude, String fcmToken) async {
    Logger().d("api data: $id, $name, ${latitude.toString()}, ${longitude.toString()}");
    String url = '$baseUrl/insert.php';
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'bio': bio,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'fcmToken': fcmToken,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d(response.body);
  }

  Future<void> insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String date,
      String runningTime, String reward, List<Map<String, dynamic>> waypointsLocation, List<String> waypointsContent, int requestType, int secondType) async {
    String url = '$baseUrl/insert_request.php';
    Logger().d('parse url data : $reqIdx, $categoryIdx, $title, $content, $address, $latitude, $longitude, $date, $runningTime, $reward, $requestType, $secondType');
    Map<String, dynamic> data = {
      'reqIdx': reqIdx,
      'category': categoryIdx,
      'title': title,
      'content': content,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'runningTime': runningTime,
      'reward': reward,
      'requestType': '$requestType',
      'secondType': '$secondType'
    };
    final response = await _client.post(Uri.parse(url), body: data);

    String requestIdx = jsonDecode(response.body).first['LAST_INSERT_ID()'].toString();
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${jsonDecode(response.body).first['LAST_INSERT_ID()'].toString()}');

    if (waypointsContent.isNotEmpty) {
      url = '$baseUrl/insert_waypoints.php';
      Logger().d("do insert waypoint");
      for (int i = 0; i < waypointsContent.length; i++) {
        Map<String, dynamic> data = {
          'requestIdx': requestIdx,
          'content': waypointsContent[i],
          'latitude': waypointsLocation[i]['latitude'],
          'longitude': waypointsLocation[i]['longitude'],
          'address': waypointsLocation[i]['address'],
        };

        final response = await _client.post(Uri.parse(url), body: data);

        Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
      }
    } else {
      Logger().d("there is no waypoints");
    }
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
      String reqIdx,
      String workerIdx,
      String categoryIdx,
      String title,
      String content,
      String address,
      String latitude,
      String longitude,
      String date,
      String runningTime,
      String reword,
      List<Map<String, dynamic>> waypointsLocation,
      List<String> waypointsContent,
      String fcmToken,
      int requestType,
      int secondType) async {
    String url = '$baseUrl/send_request_to_worker.php';
    Map<String, dynamic> data = {
      'reqIdx': reqIdx,
      'workerIdx': workerIdx,
      'category': categoryIdx,
      'title': title,
      'content': content,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'runningTime': runningTime,
      'reword': reword,
      'requestType' : requestType,
      'secondType' : secondType,
    };
    final response = await _client.post(Uri.parse(url), body: data);
    String requestIdx = jsonDecode(response.body).first['LAST_INSERT_ID()'].toString();
    Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${jsonDecode(response.body).first['LAST_INSERT_ID()'].toString()}');

    if (waypointsContent.isNotEmpty) {
      url = '$baseUrl/insert_waypoints.php';
      Logger().d("do insert waypoint");
      for (int i = 0; i < waypointsContent.length; i++) {
        Map<String, dynamic> data = {
          'requestIdx': requestIdx,
          'content': waypointsContent[i],
          'latitude': waypointsLocation[i]['latitude'],
          'longitude': waypointsLocation[i]['longitude'],
          'address': waypointsLocation[i]['address'],
        };

        final response = await _client.post(Uri.parse(url), body: data);

        Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${response.body}');
      }
    } else {
      Logger().d("there is no waypoints");
    }

    try {
      Map fcmData = {
        "token": fcmToken,
        // "topic": "user_uid",

        "notification": {
          "title": "요청서가 도착했어요!",
          "body": title,
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

  Future<bool> checkId(id) async {
    String url = '$baseUrl/check_id.php';
    Map<String, dynamic> data = {'id': id};
    final response = await _client.post(Uri.parse(url), body: data);
    if (response.body == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future updateWorkableState(String idx) async {
    String url = '$baseUrl/update_workable_state.php';
    Map<String, dynamic> data = {'idx': idx};
    await _client.post(Uri.parse(url), body: data);
  }

  Future updateNotWorkableState(String idx) async {
    String url = '$baseUrl/update_not_workable_state.php';
    Map<String, dynamic> data = {'idx': idx};
    await _client.post(Uri.parse(url), body: data);
  }

  Future<http.Response> myWallet(String idx) async {
    String url = '$baseUrl/my_wallet.php';
    Map<String, dynamic> data = {'idx': idx};
    final response = await _client.post(Uri.parse(url), body: data);
    Logger().d('#########myWalletApi : ${response.body}');
    return response;
  }

  Future<http.Response> getAnnouncement() async {
    String url = '$baseUrl/announcement.php';
    final response = await _client.post(Uri.parse(url));
    return response;
  }
}
