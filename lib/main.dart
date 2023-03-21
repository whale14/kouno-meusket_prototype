import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/data/repository/chat_repository_impl.dart';
import 'package:test_project/data/repository/test_repository_impl.dart';
import 'package:test_project/data/source/remote/chat_api.dart';
import 'package:test_project/data/source/remote/test_api.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/config/shared_preferences.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/screen/home_screen.dart';
import 'package:logger/logger.dart';
import 'package:test_project/data/repository/errand_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/presentation/vm/test_view_model.dart';
import 'package:test_project/screen/join_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _permission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: '64ba3b8a596d221c8216b7ce7f89af66');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TestViewModel(ErrandRepositoryImpl(ErrandApi()))),
      ChangeNotifierProvider(create: (_) => RequestViewModel(ErrandRepositoryImpl(ErrandApi()))),
      ChangeNotifierProvider(create: (_) => ChatViewModel(ChatRepositoryImpl(ChatApi()))),
    ],
    child: const MyApp(),
  ));
}

Future<void> _permission() async {
  var requestStatus = await Permission.location.request();
  var status = await Permission.location.status;
  if (requestStatus.isGranted && status.isLimited) {
    // isLimited -  제한적 동의
    // 요청 동의함
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      var position = await Geolocator.getCurrentPosition();
    } else {
      //요청동의 꺼짐
    }
  } else if (requestStatus.isPermanentlyDenied || status.isPermanentlyDenied) {
    // 권한 요청 거부 -> 설정 변경(android)
    openAppSettings();
  } else if (requestStatus.isRestricted) {
    // 권한 요청 거부 설정 변경 함(ios)
    openAppSettings();
  } else if (status.isDenied) {
    //권한 요청 거절
    SystemNavigator.pop(); // 앱종료
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarcsted.
            primarySwatch: Colors.orange,
            appBarTheme: const AppBarTheme(centerTitle: true, titleTextStyle: TextStyle(color: Colors.orange))),
        home: FutureBuilder(
            future: sharedPreferencesService.isLoggedIn(),
            builder: (context, snapshot) {
              Logger().d("isLoggedIn? : ${snapshot.data}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData && snapshot.data == true) {
                  return FutureBuilder(
                    future: sharedPreferencesService.getUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return TabPage(snapshot.data!);
                      }
                    },
                  );
                } else {
                  return const LoginPage();
                }
              }
            }) //TabPage(),
        );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signInWithKakao(BuildContext context) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();

      User user = await UserApi.instance.me();
      String userId = 'id${user.id}';

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JoinPage(userId)));

      // final url = Uri.https('kap.kakao.com', '/v2/user/me');
      //
      // final response = await http.get(url, headers: {
      //   HttpHeaders.authorizationHeader: 'Bearer${token.accessToken}'
      // });
      // final profileInfo = json.decode(response.body);
    } catch (e) {
      Logger().d("Login Failed...${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            signInWithKakao(context);
          },
          child: Text("kakao login")),
    ));
  }
}
