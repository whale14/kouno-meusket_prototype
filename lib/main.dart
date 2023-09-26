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
import 'package:test_project/data/repository/wallet_repository_impl.dart';
import 'package:test_project/data/source/remote/chat_api.dart';
import 'package:test_project/controller/shared_preferences.dart';
import 'package:test_project/data/source/remote/review_api.dart';
import 'package:test_project/data/source/remote/wallet_api.dart';
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
import 'package:test_project/presentation/vm/wallet_view_model.dart';
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
  WidgetsFlutterBinding.ensureInitialized(); // 파이어베이스 패키지 사용을위한 바인딩함수 초기화 https://velog.io/@kyj5394/WidgetsFlutterBinding.ensureInitialized-%EC%82%AC%EC%9A%A9-%EC%9D%B4%EC%9C%A0
  await initializeDateFormatting(); // 달력 위젯을 한글로 사용하기위한 메소드
  await _permission(); //위치정보 사용권한 및 동의 요청 L.102
  KakaoSdk.init(nativeAppKey: '64ba3b8a596d221c8216b7ce7f89af66'); //카카오 api사용을위한 초기화함수 카카오api 콘솔에서 nativeAppkey를 발급받아 사용한다.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); //파이어베이스 초기화 함수
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); //  fcm 백그라운드 대기 (공식문서)
  if (!kIsWeb) {
    await setupFlutterNotifications(); //알림 설정 - L.49
  }
  runApp(MultiProvider(
    // 두 개 이상의 viewModel을 사용하기위해 multiProvider 호출 - 아래 providers리스트에 사용하려는 뷰모델을 추가하면 된다.
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel(UserRepositoryImpl(UserAPI()))),
      ChangeNotifierProvider(create: (_) => RequestViewModel(ErrandRepositoryImpl(ErrandApi()))),
      ChangeNotifierProvider(create: (_) => ChatViewModel(ChatRepositoryImpl(ChatApi()))),
      ChangeNotifierProvider(create: (_) => ReviewViewModel(ReviewRepositoryImpl(ReviewApi()))),
      ChangeNotifierProvider(create: (_) => WalletViewModel(WalletRepositoryImpl(WalletApi()))),
    ],
    child: MyApp(), //앱실행 L.126
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
      builder: FToastBuilder(), // flutterToast 사용을 위해 루트에 toastbuilder추가 - https://pub.dev/packages/fluttertoast 공식문서
      title: 'Flutter Demo',
      theme: ThemeData( // 앱 테마
        primarySwatch: Colors.orange, //기본 색상
        iconTheme: const IconThemeData(color: Colors.orange), //아이콘 기본 색상
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black87))), // 텍스트 버튼 기본 설정
        appBarTheme: const AppBarTheme( //앱바(상단에 표시되는 바 테마) 기본설정
          color: Colors.white, // 앱바 배경색
          centerTitle: true, //제목 가운데정렬
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),  //텍스트크기, 텍스트타입(볼드), 텍스트색상
        ),
      ),
      home: const SplashScreen(), // 로그인 이력이 있는지 판단하는 페이지 - L.151
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
    await SharedPreferencesService().isLoggedIn().then((value) async { //sharedPreference(일종의 모바일 로컬 저장소)에 로그인 여부가 저장되어있는지 판단하는 코드
      if (value) { // 저장되어있다면 해당 정보를 담아 로그인후 화면으로 이동
        String userId = await SharedPreferencesService().getUserId(); //sharedPreference에 저장되어있는 userId를 가져온다.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LookAround(userId), // look_around.dart
            // builder: (context) => LoginPage(),
          ),
        );
      } else { // 로그인 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(), //L.194
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moveScreen(); //L.165
    return const Scaffold(body: Center(child: CircularProgressIndicator())); //moveScreen()이 실행되는동안 로딩화면을 보여준다.
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //statefulWidget의 필드변수, 함수 선언부
  late UserViewModel _viewModel;
  late UserState _state;
  bool _isLogin = false;
  late String _userId;

  Future<void> signInWithKakao(BuildContext context) async { //카카오 로그인 관련함수 공식문서 https://developers.kakao.com/docs/latest/ko/kakaologin/flutter
    try {
      bool isInstalled = await isKakaoTalkInstalled(); //카카오톡 설치여부를 반환하는 함수
      OAuthToken token = isInstalled ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount(); //설치되어있다면 카카오톡연결 아니라면 웹페이지 연결
      User user = await UserApi.instance.me(); // 카카오톡 사용자 정보 요청
      String userId = 'id${user.id}';
      //

      try {
        await _viewModel.onUsersEvent(UsersEvent.getUser(userId)).then((value) {
          _isLogin = true;
          _userId = userId;
        });
      } catch(e) { //처음 가입하는 유저일 경우
        Logger().d(e.hashCode);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JoinPage(userId),
            ));
      }
      if (_isLogin) { //이미 가입한 유저일 경우
        if (_state.user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              // sharedPreference 에 로그인 정보 저장(splashScreen에서 자동 로그인)
              SharedPreferencesService().setIdx(_state.user!.idx.toString());
              SharedPreferencesService().setLoggedIn(true);
              SharedPreferencesService().setUserId(_state.user!.id);
              return LookAround(_state.user!.id); // 로그인 이후 첫화면 페이지
            },
          ));
        }
      }

    } catch (e) {
      Logger().d("Login Failed...${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) { //화면 구성
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
                await signInWithKakao(context); // 카카오 로그인
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
