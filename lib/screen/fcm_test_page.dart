import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

class FCMTestPage extends StatefulWidget {
  const FCMTestPage({Key? key}) : super(key: key);

  @override
  State<FCMTestPage> createState() => _FCMTestPageState();
}

class _FCMTestPageState extends State<FCMTestPage> {
  late UserViewModel _viewModel;
  late UserState _state;

  Future getFcmToken() async {
    Logger().d(await FirebaseMessaging.instance.getToken());
  }

  @override
  void initState() {
    // TODO: implement initState
    getFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.read();
    _state = _viewModel.userState;
    var fcmToken =
        "dQVzfo53StGl9fK7rDvKX9:APA91bHkzkcvm9PSZWGpnsyyI6LI0A26iWlA8p_coQ-2TrBQHgMlvzQk_5jDXe1sZaqBfUmjIZmEkLcG0LZ3UOxk3_tXl_pVu2MNHUlehQatP4Erow8u20pxZP1J0MMp6fn36g6TMDFS";
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            _postMessage(fcmToken);
          },
          child: Text("FCM TEST"),
        ),
      ),
    );
  }

  Future _postMessage(String fcmToken) async {
    try {
      Map data = {
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
        body: json.encode(data),

        /*body: json.encode({
            "message": {
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
                  "aps": {
                    "category": "Message Category",
                    "content-available": 1
                  }
                }
              }
            }
          }));*/
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
