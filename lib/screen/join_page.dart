import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/screen/look_around.dart';

import '../config/shared_preferences.dart';
import '../presentation/vm/user_view_model.dart';

class JoinPage extends StatefulWidget {
  final String userId;

  const JoinPage(this.userId, {Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _controller = TextEditingController();
  late double latitude;
  late double longitude;
  late String _userId;

  late SharedPreferences prefs;

  late UsersState usersState;

  Future<void> _getCurrentLocation() async {
    WidgetsFlutterBinding.ensureInitialized();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    _userId = widget.userId;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: "input name"),
              controller: _controller,
            ),
            MaterialButton(
                color: Colors.orange,
                child: const Text('start App'),
                onPressed: () async{
                  String? fcmToken = await FirebaseMessaging.instance.getToken();
                  await viewModel.onUsersEvent(UsersEvent.insert(_userId, _controller.value.text.trim(), latitude, longitude, fcmToken!));

                  await viewModel.onUsersEvent(UsersEvent.getAroundHelpers(_userId));
                  usersState = viewModel.usersState;
                  Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!join idx:${usersState.myIdx.toString()}');
                  SharedPreferencesService().setIdx(usersState.myIdx);
                  SharedPreferencesService().setLoggedIn(true);
                  SharedPreferencesService().setUserId(_userId);
                  Logger().d("id : $_userId, name : ${_controller.value.text.trim()}, latitude : $latitude, longitude : $longitude");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LookAround(_userId),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
