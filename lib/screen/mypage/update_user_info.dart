import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/file_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

class UpdateUserInfo extends StatefulWidget {
  const UpdateUserInfo({Key? key}) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  late UserViewModel _userViewModel;
  late UserState _userState;
  XFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_profileImage == null)
                  Icon(
                    Icons.account_circle,
                    size: 200,
                  )
                else
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.orange),
                      image: DecorationImage(image: FileImage(File(_profileImage!.path)), fit: BoxFit.cover),
                    ),
                  ),
                MaterialButton(
                  onPressed: () => _showSelectPhotoSheet(),
                  child: Text("사진 변경"),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: MaterialButton(
              color: Colors.orange,
              onPressed: () {
                if(_profileImage != null) {
                  final sendData = _profileImage!.path;
                  final fileViewModel = FileViewModel();
                  final fileName = "pi${_userState.user!.idx}.png";
                  fileViewModel.uploadImage(sendData, fileName);
                  _userViewModel.onUsersEvent(UsersEvent.updateUserInfo(_userState.user!.idx.toString(), fileName));
                } else {
                  Logger().d("이미지를 선택해");
                }
              },
              minWidth: double.maxFinite,
              child: Text("수정하기"),
            ),
          )
        ],
      ),
    );
  }

  _showSelectPhotoSheet() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => _takePicture().then((value) => Navigator.pop(context)),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: Text(
                    "사진 찍기",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _selectPhoto().then((value) => Navigator.pop(context)),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: Text(
                    "라이브러리 선택",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future _takePicture() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    } else {
      Logger().d('이미지 선택 취소');
    }
  }

  Future _selectPhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    } else {
      Logger().d('이미지 선택 취소');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
