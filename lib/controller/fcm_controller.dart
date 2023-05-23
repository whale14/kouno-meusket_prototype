import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class FCMController {
  final FirebaseMessaging fcm;

  FCMController(this.fcm);



  //푸시알림 허용 요청
  Future requestPermission() async {
    NotificationSettings previousSettings = await fcm.getNotificationSettings();

    // 사용자가 결정하지 않은 경우 허용 요청 보냄
    if(previousSettings.authorizationStatus == AuthorizationStatus.notDetermined) {
      NotificationSettings notificationSettings = await fcm.requestPermission(
        alert: true,
        announcement: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.authorized) {
        Logger().d('User granted permission');
      } else if (notificationSettings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        Logger().d('User granted provisional permission');
      } else {
        Logger().d('User declined or has not accepted permission');
      }
    }
  }

  Future getMessage() async{
    RemoteMessage? message = await fcm.getInitialMessage();
  }
}