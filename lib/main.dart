import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_project/data/repository/chat_repository_impl.dart';
import 'package:test_project/data/repository/review_repository_impl.dart';
import 'package:test_project/data/repository/user_repository_impl.dart';
import 'package:test_project/data/source/remote/chat_api.dart';
import 'package:test_project/controller/shared_preferences.dart';
import 'package:test_project/data/source/remote/review_api.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/chat_view_model.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:logger/logger.dart';
import 'package:test_project/data/repository/errand_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/source/remote/errand_api.dart';
import 'package:test_project/presentation/vm/review_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/join_page.dart';
import 'package:test_project/screen/look_around.dart';
import 'package:test_project/data/source/remote/user_api.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger().d('Handling a background message ${message.messageId}');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // showFlutterNotification(message);
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool isFlutterLocalNotificationsInitialized = false;

Future setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
      'high_importance_channel', //id
      'High_Importance_Notifications', //title
      description: 'This channel is used for important notifications.',
      importance: Importance.high);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description, icon: 'launch_background'),
      ),
    );
    Logger().d(android.clickAction);
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await _permission();
  KakaoSdk.init(nativeAppKey: '64ba3b8a596d221c8216b7ce7f89af66');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel(UserRepositoryImpl(UserAPI()))),
      ChangeNotifierProvider(create: (_) => RequestViewModel(ErrandRepositoryImpl(ErrandApi()))),
      ChangeNotifierProvider(create: (_) => ChatViewModel(ChatRepositoryImpl(ChatApi()))),
      ChangeNotifierProvider(create: (_) => ReviewViewModel(ReviewRepositoryImpl(ReviewApi()))),
    ],
    child: MyApp(),
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
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: const {"/tab": TabPage()},
      builder: FToastBuilder(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.orange),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black87))),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      home: const SplashScreen(), //TabPage(),
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
    await SharedPreferencesService().isLoggedIn().then((value) async {
      if (value) {
        String userId = await SharedPreferencesService().getUserId();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LookAround(userId),
            // builder: (context) => LoginPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
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
  late UserViewModel _viewModel;
  late UserState _state;
  bool _isLogin = false;
  late String _userId;

  Future<void> signInWithKakao(BuildContext context) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();

      User user = await UserApi.instance.me();
      String userId = 'id${user.id}';
      //

      try {
        await _viewModel.onUsersEvent(UsersEvent.getUser(userId)).then((value) {
          _isLogin = true;
          _userId = userId;
        });
      } catch(e) {
        Logger().d(e.hashCode);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JoinPage(userId),
            ));
      }
      if (_isLogin) {
        if (_state.user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              SharedPreferencesService().setIdx(_state.user!.idx.toString());
              SharedPreferencesService().setLoggedIn(true);
              SharedPreferencesService().setUserId(_state.user!.id);
              return LookAround(_state.user!.id);
            },
          ));
        }
      }

    } catch (e) {
      Logger().d("Login Failed...${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserViewModel>();
    _state = _viewModel.userState;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(width: double.maxFinite, child: SvgPicture.asset("asset/logo/MEUSKET_logo.svg")),
          SizedBox(
            height: 64,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("열심히 ", style: TextStyle(fontSize: 24, color: Color(0xffBF9D75))),
              Text("일하고,", style: TextStyle(fontSize: 24, color: Color(0xffE77924))),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("더많이 ", style: TextStyle(fontSize: 24, color: Color(0xffBF9D75))),
              Text("벌고,", style: TextStyle(fontSize: 24, color: Color(0xffE77924))),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("보상을 ", style: TextStyle(fontSize: 24, color: Color(0xffBF9D75))),
              Text("받으세요", style: TextStyle(fontSize: 24, color: Color(0xffE77924))),
            ],
          ),
          SizedBox(
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: GestureDetector(
              onTap: () async {
                await signInWithKakao(context);
              },
              child: Image.asset("asset/image/kakao_login/ko/kakao_login_large_wide.png"),
            ),
          ),
          SizedBox(
            height: 64,
          )
        ],
      ),
    );
  }
}
