import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/data/repository/chat_repository_impl.dart';
import 'package:test_project/data/repository/user_repository_impl.dart';
import 'package:test_project/data/source/remote/chat_api.dart';
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
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/join_page.dart';
import 'package:test_project/screen/look_around.dart';
import 'package:test_project/data/source/remote/user_api.dart';
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
      ChangeNotifierProvider(create: (_) => UserViewModel(UserRepositoryImpl(UserAPI()))),
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          iconTheme: IconThemeData(color: Colors.orange),
          appBarTheme: const AppBarTheme(centerTitle: true, titleTextStyle: TextStyle(color: Colors.orange))),
      home: SplashScreen(), //TabPage(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void moveScreen() async {
    await SharedPreferencesService().isLoggedIn().then((value) async{
      if(value) {
        String userId = await SharedPreferencesService().getUserId();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LookAround(userId),));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moveScreen();
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
          child: const Text("kakao login")),
    ));
  }
}
