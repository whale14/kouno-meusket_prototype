import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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

  List<bool?> tpCheckList = [];
  List<bool?> wcCheckList = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();

  late String _name, _bio, _introduce, _myTp, _myWc;

  final List<String> transportations = ["도보", "자전거", "킥보드", "오토바이", "자동차", "용달"];
  final List<String> categories = ["배달/구매 대행", "청소/가사 도움", "운반/수리", "동행/돌봄", "단기알바"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userViewModel = context.read<UserViewModel>();
    _userState = _userViewModel.userState;
    initialTextEditingControllersText();
  }

  initialTextEditingControllersText() {
    _name = _userState.user!.name;
    if(_userState.user!.bio != null) {
      _bio = _userState.user!.bio!;
    } else {
      _bio = "";
    }

    if(_userState.user!.introduce != null) {
      _introduce = _userState.user!.introduce!;
    } else {
      _introduce = "";
    }

    if(_userState.user!.transportation != null) {
      _myTp = _userState.user!.transportation!;
    } else {
      _myTp = "";
    }

    if(_userState.user!.workCategory != null) {
      _myWc = _userState.user!.workCategory!;
    } else {
      _myWc = "";
    }
  }

  @override
  Widget build(BuildContext context) {

    _nameController.text = _name;
    _bioController.text = _bio;
    _introduceController.text = _introduce;

    return Scaffold(
      appBar: AppBar(title: const Text("회원 정보 수정")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () => _showSelectPhotoSheet(), //찍기 또는 선택 모달팝업 연결
                    child: Stack(
                      children: [
                        _imageContainer(100),
                        Positioned(
                          bottom: 1,
                          right: 1,
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
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "set profile image",
                    style: TextStyle(color: Colors.orange),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                    child: Column(
                      children: [
                        Row(                                                                      //!!!!!!!!!!!!!!!!NAME!!!!!!!!!!!!!!!!!!!
                          children: [
                            const SizedBox(width: 80, child: Text("이름")),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  _name = value;
                                },
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(                                                                      //!!!!!!!!!!!!!!!!BIO!!!!!!!!!!!!!!!!!!!
                          children: [
                            const SizedBox(width: 80, child: Text("bio")),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  _bio = value;
                                },
                                controller: _bioController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if(_userState.user!.isWorkerRegist == 1)Row(                                                                      //!!!!!!!!!!!!!!!!INTRODUCE!!!!!!!!!!!!!!!!!!!
                          children: [
                            const SizedBox(width: 80, child: Text("자기소개")),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  _introduce = value;
                                },
                                maxLines: 3,
                                controller: _introduceController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if(_userState.user!.isWorkerRegist == 1)Container(                                                                      //!!!!!!!!!!!!!!!!TRANSPORTATION!!!!!!!!!!!!!!!!!!!
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                          child: Row(
                            children: [
                              const SizedBox(width: 80, child: Text("이동수단")),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: transportations.length,
                                  itemBuilder: (context, index) {
                                    bool? checkVal = false;
                                    if(_userState.user!.transportation != null) {
                                      if(_userState.user!.transportation!.contains(transportations[index])) {
                                        checkVal = true;
                                      }
                                    }
                                    tpCheckList.add(checkVal);
                                    return CheckboxListTile(
                                      title: Text(transportations[index]),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (value) => setState(() {
                                        tpCheckList[index] = value;
                                      }),
                                      value: tpCheckList[index],
                                    );
                                  },),
                                ),
                            ],
                          ),
                        ),
                        if(_userState.user!.isWorkerRegist == 1)Container(                                                                      //!!!!!!!!!!!!!!!!WORK CATEGORY!!!!!!!!!!!!!!!!!!!
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                          child: Row(
                            children: [
                              const SizedBox(width: 80, child: Text("가능한 심부름")),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    bool? checkVal = false;
                                    if(_userState.user!.workCategory != null) {
                                      if(_userState.user!.workCategory!.contains(categories[index])) {
                                        checkVal = true;
                                      }
                                    }
                                    wcCheckList.add(checkVal);
                                    return CheckboxListTile(
                                      title: Text(categories[index]),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (value) => setState(() {
                                        wcCheckList[index] = value;
                                      }),
                                      value: wcCheckList[index],
                                    );
                                  },),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              color: Colors.orange,
              onPressed: () async {

                bool changCheck = false;



                if(_userState.user!.isWorkerRegist == 0) {
                  //프로필 이미지 변경
                  if (_profileImage != null) {
                    final sendData = _profileImage!.path;
                    final fileViewModel = FileViewModel();
                    final fileName = "pi${_userState.user!.idx}.png";
                    await fileViewModel.uploadImage(sendData, fileName);
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserPhoto(_userState.user!.idx.toString(), fileName));

                    changCheck = true;
                  }

                  //이름 변경
                  if(_name.trim() != _userState.user!.name) {
                    if(_name.trim() != "") {
                      await _userViewModel.onUsersEvent(UsersEvent.updateUserName(_userState.user!.idx.toString(), _name.trim()));
                      changCheck = true;
                    }
                  }

                  //bio 변경
                  if(_userState.user!.bio != _bio.trim()) {
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserBio(_userState.user!.idx.toString(), _bio.trim()));
                    changCheck = true;
                  }

                  if(changCheck) {
                    await _userViewModel.onUsersEvent(UsersEvent.getUser(_userState.user!.id)).then((value) => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  if (_profileImage != null) {
                    final sendData = _profileImage!.path;
                    final fileViewModel = FileViewModel();
                    final fileName = "pi${_userState.user!.idx}.png";
                    await fileViewModel.uploadImage(sendData, fileName);
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserPhoto(_userState.user!.idx.toString(), fileName));

                    changCheck = true;
                  }

                  //이름 변경
                  if(_name.trim() != _userState.user!.name) {
                    if(_name.trim() != "") {
                      await _userViewModel.onUsersEvent(UsersEvent.updateUserName(_userState.user!.idx.toString(), _name.trim()));
                      changCheck = true;
                    }
                  }

                  //bio 변경
                  if(_userState.user!.bio != _bio.trim()) {
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserBio(_userState.user!.idx.toString(), _bio.trim()));
                    changCheck = true;
                  }

                  //introduce 변경
                  if(_userState.user!.introduce != _introduce.trim()) {
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserIntroduce(_userState.user!.idx.toString(), _introduce.trim()));
                    changCheck = true;
                  }

                  //이동수단 변경
                  String tpUpdate = "";
                  for(int i = 0; i<transportations.length; i++) {
                    if(tpCheckList[i] == true) {
                      tpUpdate += "${transportations[i]},";
                    }
                  }
                  if(tpUpdate != "") {
                    tpUpdate = tpUpdate.substring(0, tpUpdate.length - 1);
                  }
                  if(tpUpdate != _myTp) {
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserTransportation(_userState.user!.idx.toString(), tpUpdate));
                    changCheck = true;
                  }

                  //가능한 심부름 변경
                  String wcUpdate = "";
                  for(int i = 0; i<categories.length; i++) {
                    if(wcCheckList[i] == true) {
                      wcUpdate += "${categories[i]},";
                    }
                  }
                  if(wcUpdate != "") {
                    wcUpdate = wcUpdate.substring(0, wcUpdate.length - 1);
                  }
                  if(wcUpdate != _myWc) {
                    await _userViewModel.onUsersEvent(UsersEvent.updateUserWorkCategory(_userState.user!.idx.toString(), wcUpdate));
                    changCheck = true;
                  }

                  if(changCheck) {
                    await _userViewModel.onUsersEvent(UsersEvent.getUser(_userState.user!.id)).then((value) => Navigator.pop(context));
                  } else {
                    Navigator.pop(context);
                  }
                }

              },
              minWidth: double.maxFinite,
              child: const Text(
                "수정하기",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }




  Widget _imageContainer(double size) {
    if (_userState.user!.profileImageUrl == null) {
      if (_profileImage == null) {
        return const Icon(
          Icons.account_circle,
          size: 100,
        );
      } else {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.orange),
            image: DecorationImage(image: FileImage(File(_profileImage!.path)), fit: BoxFit.cover),
          ),
        );
      }
    } else {
      if (_profileImage == null) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.orange),
            image: DecorationImage(image: NetworkImage("http://${_userState.user!.profileImageUrl!}"), fit: BoxFit.cover),
          ),
        );
      } else {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.orange),
            image: DecorationImage(image: FileImage(File(_profileImage!.path)), fit: BoxFit.cover),
          ),
        );
      }
    }
  } //이미지틀




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




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
