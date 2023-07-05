import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/screen/look_around.dart';

import '../controller/shared_preferences.dart';
import '../presentation/vm/user_view_model.dart';

class JoinPage extends StatefulWidget {
  final String userId;

  const JoinPage(this.userId, {Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _nameController = TextEditingController();
  late double latitude;
  late double longitude;
  late String _userId;

  late SharedPreferences prefs;

  late UsersState usersState;

  final _bioController = TextEditingController();

  XFile? _profileImage;

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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      SvgPicture.asset("asset/logo/logo_ko.svg"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("프로필 설정", style: TextStyle(fontSize: 18, color: Color(0xffE77924))),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () => _showSelectPhotoSheet(), //찍기 또는 선택 모달팝업 연결
                        child: Stack(
                          children: [
                            _imageContainer(145),
                            Positioned(
                              bottom: 7.75,
                              right: 7.75,
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text("닉네임", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xffE77924))),
                SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xffBDBDBD)),
                    hintText: "닉네임을 정해주세요.(10자 이내)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                  controller: _nameController,
                ),
                SizedBox(height: 48),
                Text("한줄소개", style: TextStyle(fontSize: 24, color: Color(0xffE77924))),
                SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xffBDBDBD)),
                    hintText: "자신을 나타낼 수 있는 문구를 작성해주세요(30자 이내)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                  controller: _bioController,
                ),
                SizedBox(height: 48),
                InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        gradient: LinearGradient(colors: [Color(0xffF8A239), Color(0xffEB8229)], begin: Alignment.topLeft, end: Alignment.bottomRight,),
                      ),
                      child: const Text(
                        '미어켓 시작하기',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                    onTap: () async {
                      String? fcmToken = await FirebaseMessaging.instance.getToken();
                      await viewModel.onUsersEvent(UsersEvent.insert(_userId, _nameController.value.text.trim(), latitude, longitude, fcmToken!));

                      await viewModel.onUsersEvent(UsersEvent.getAroundHelpers(_userId));
                      usersState = viewModel.usersState;
                      Logger().d('!!!!!!!!!!!!!!!!!!!!!!!!!join idx:${usersState.myIdx.toString()}');
                      SharedPreferencesService().setIdx(usersState.myIdx);
                      SharedPreferencesService().setLoggedIn(true);
                      SharedPreferencesService().setUserId(_userId);
                      Logger().d("id : $_userId, name : ${_nameController.value.text.trim()}, latitude : $latitude, longitude : $longitude");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LookAround(_userId),
                          ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageContainer(double size) {
    if (_profileImage == null) {
      return SvgPicture.asset(
        "asset/icons/profile_pic.svg",
        width: size,
        height: size,
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.orange),
          image: DecorationImage(image: FileImage(File(_profileImage!.path)), fit: BoxFit.cover),
        ),
      );
    }
  }

  _showSelectPhotoSheet() {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _takePicture().then((value) => Navigator.pop(context));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: const Text(
                    "사진 찍기",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _selectPhoto().then((value) => Navigator.pop(context)),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: const Text(
                    "라이브러리 선택",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              )
            ],
          );
        });
  } //바텀모달

  _takePicture() async {
    await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 2000, maxWidth: 2000, imageQuality: 50).then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
    // if (pickedFile != null) {
    //   _profileImage = pickedFile;
    // } else {
    //   Logger().d('이미지 선택 취소');
    // }
  } //사진찍기

  Future _selectPhoto() async {
    await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 2000, maxWidth: 2000, imageQuality: 50).then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  } //갤러리 선택

  _cropImage(File file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
            ]
          : [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        _profileImage = XFile(croppedFile.path);
      });
    }
  } //이미지 자르기(정방형)
}
