import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

//기본 정보 입력
class WorkerRegistrationPage extends StatefulWidget {
  const WorkerRegistrationPage({Key? key}) : super(key: key);

  @override
  State<WorkerRegistrationPage> createState() => _WorkerRegistrationPageState();
}

class _WorkerRegistrationPageState extends State<WorkerRegistrationPage> {
  final _nameController = TextEditingController();
  final _rrnText = TextRecognizer(script: TextRecognitionScript.korean);
  XFile? _profileImage;
  String _rt = "";

  late String _recognitionText;

  late String _name;

  bool _isDisable = true;

  final fToast = FToast();

  List<String> _infs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast.init(context);
  }

  _showToast(String text, Color color) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('기본정보')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                _name = value;
                if (value.trim().compareTo(_rt.trim()) == 0) {
                  setState(() {
                    _isDisable = false;
                    Logger().d("same!!!");
                  });
                } else {
                  setState(() {
                    _isDisable = true;
                    Logger().d("different!!! : $value, $_rt");
                  });
                }
              },
              controller: _nameController,
              decoration: const InputDecoration(label: Text("본명"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
            ),
            const SizedBox(
              height: 30,
            ),
            if (_profileImage == null)
              DottedBorder(
                radius: const Radius.circular(12),
                dashPattern: const [8, 4],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: GestureDetector(
                    onTap: () {
                      _takePicture();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 10 * MediaQuery.of(context).devicePixelRatio,
                      height: MediaQuery.of(context).size.width / 1.5925 - 10 * MediaQuery.of(context).devicePixelRatio,
                      child: const Text("신분증 등록"),
                    ),
                  ),
                ),
              )
            else
              DottedBorder(
                radius: const Radius.circular(12),
                dashPattern: const [8, 4],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: GestureDetector(
                    onTap: () {
                      _takePicture();
                    },
                    child: Container(
                      decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(_profileImage!.path)))),
                      width: MediaQuery.of(context).size.width - 10 * MediaQuery.of(context).devicePixelRatio,
                      height: MediaQuery.of(context).size.width / 1.5925 - 10 * MediaQuery.of(context).devicePixelRatio,
                    ),
                  ),
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: _isDisable
                    ? null
                    : () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            _infs.clear();
                            _infs.add(_recognitionText);
                            return InputAccountPage(_profileImage!.path, _infs);
                          },
                        ));
                      },
                child: const Text(
                  "다음",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _takePicture() async {
    await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 2000, maxWidth: 2000, imageQuality: 50).then((value) {
      if (value != null) {
        _cropImage(File(value.path)).then((value) => null);
      }
    });
    // if (pickedFile != null) {
    //   _profileImage = pickedFile;
    // } else {
    //   Logger().d('이미지 선택 취소');
    // }
  }

  Future _cropImage(File file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 8.6, ratioY: 5.4),
      // aspectRatioPresets: Platform.isAndroid
      //     ? [
      //   CropAspectRatioPreset.square,
      // ]
      //     : [CropAspectRatioPreset.sq uare],
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
        textRecognizing(croppedFile.path);
      });
    }
  }

  Future textRecognizing(String path) async {
    var image = InputImage.fromFilePath(path);
    try {
      var text = await _rrnText.processImage(image);
      for (var element in text.blocks) {
        Logger().d(element.text);
      }
      setState(() {
        _rt = text.blocks[0].text.substring(5, 9).trim();
        _recognitionText = text.text;
        if (_rt.trim() == _name) {
          Logger().d("same!");
          _isDisable = false;
          _showToast("내용 일치", Colors.greenAccent);
        } else {
          _isDisable = true;
          _showToast("입력한 본명과 신분증의 내용이 다릅니다", Colors.redAccent);
        }
      });
    } catch (e) {
      Logger().d(e);
      _showToast(e.hashCode.toString(), Colors.redAccent);
    }
  } //사진찍기
}

// 계좌 정보 입력
class InputAccountPage extends StatefulWidget {
  final String path;
  final List<String> infs;

  const InputAccountPage(this.path, this.infs, {Key? key}) : super(key: key);

  @override
  State<InputAccountPage> createState() => _InputAccountPageState();
}

class _InputAccountPageState extends State<InputAccountPage> {
  final _nameController = TextEditingController();

  // final _rrnController1 = TextEditingController();
  // final _rrnController2 = TextEditingController();
  final _bankController = TextEditingController();
  final _accountController = TextEditingController();

  bool _isDisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("입금계좌 정보"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                if (_accountController.text != "" && _bankController.text != "" && _nameController.text != "") {
                  setState(() {
                    _isDisable = false;
                  });
                }
              },
              controller: _nameController,
              decoration: const InputDecoration(label: Text("예금주명"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
            ),
            const SizedBox(height: 10),
            /*Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'\d'),
                      ),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _rrnController1,
                    decoration: InputDecoration(label: Text("주민등록번호"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text("-"),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'\d'),
                      ),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _rrnController2,
                    decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
                  ),
                ),
              ],
            ),*/ //주민등록번호 꼭 필요한가
            //은행선택
            TextField(
              controller: _bankController,
              onChanged: (value) {
                if (_accountController.text != "" && _bankController.text != "" && _nameController.text != "") {
                  setState(() {
                    _isDisable = false;
                  });
                }
              },
              decoration: const InputDecoration(label: Text("입금은행"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                if (_accountController.text != "" && _bankController.text != "" && _nameController.text != "") {
                  setState(() {
                    _isDisable = false;
                  });
                }
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d')), FilteringTextInputFormatter.digitsOnly],
              controller: _accountController,
              decoration: const InputDecoration(label: Text("계좌번호"), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: _isDisable
                    ? null
                    : () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            List<String> _infs = widget.infs;
                            _infs.add(_nameController.text.trim());
                            _infs.add(_bankController.text.trim());
                            _infs.add(_accountController.text.trim());
                            return InputPicturePage(widget.path, _infs);
                          },
                        ));
                      },
                child: const Text(
                  "다음",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//인증용 사진 입력
class InputPicturePage extends StatefulWidget {
  final String path;
  final List<String> infs;

  const InputPicturePage(this.path, this.infs, {Key? key}) : super(key: key);

  @override
  State<InputPicturePage> createState() => _InputPicturePageState();
}

class _InputPicturePageState extends State<InputPicturePage> {
  XFile? _image;
  bool _isDisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("본인사진"),
      ),
      body: Column(
        children: [
          if (_image == null)
            Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => _showSelectPhotoSheet(),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 10 * MediaQuery.of(context).devicePixelRatio,
                    child: const Text("사진 등록"),
                  ),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => _showSelectPhotoSheet(),
                child: DottedBorder(
                  dashPattern: const [8, 4],
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 10 * MediaQuery.of(context).devicePixelRatio,
                    decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(_image!.path)))),
                  ),
                ),
              ),
            ),
          const Spacer(),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: _isDisable
                  ? null
                  : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return InputWorkerInfoPage(
                            widget.path,
                            _image!.path,
                            widget.infs,
                          );
                        },
                      ));
                    },
              child: const Text("다음"),
            ),
          ),
        ],
      ),
    );
  }

  _showSelectPhotoSheet() { //사진촬영 or 라이브러리에서 사진 가져오기 선택 모달
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
        _image = XFile(croppedFile.path);
        _isDisable = false;
      });
    }
  }
}

class InputWorkerInfoPage extends StatefulWidget {
  final String idCardPath;
  final String faceCheckPath;
  final List<String> infs;

  const InputWorkerInfoPage(this.idCardPath, this.faceCheckPath, this.infs, {Key? key}) : super(key: key);

  @override
  State<InputWorkerInfoPage> createState() => _InputWorkerInfoPageState();
}

class _InputWorkerInfoPageState extends State<InputWorkerInfoPage> {
  final _introduceController = TextEditingController();
  final List<String> transportations = ["도보", "자전거", "킥보드", "오토바이", "자동차", "용달"];
  final List<String> categories = ["배달/구매 대행", "청소/가사 도움", "운반/수리", "동행/돌봄", "단기알바"];

  List<bool?> tpCheckList = [];
  List<bool?> wcCheckList = [];

  bool _checkAll = false;
  final List<String> _termsName = ["약관1", "약관2", "약관3", "약관4"];
  final List<bool> _termsCheck = [false, false, false, false];

  bool _isDisable = true;

  late UserViewModel _viewModel;
  late UserState _state;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.read<UserViewModel>();
    _state = _viewModel.userState;
    return Scaffold(
      appBar: AppBar(
        title: const Text("드림이 정보 입력"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    //!!!!!!!!!!!!!!!!INTRODUCE!!!!!!!!!!!!!!!!!!!
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(width: 80, child: Text("자기소개")),
                      Expanded(
                        child: TextField(
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
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    //!!!!!!!!!!!!!!!!TRANSPORTATION!!!!!!!!!!!!!!!!!!!
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        const SizedBox(width: 80, child: Text("이동수단")),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transportations.length,
                            itemBuilder: (context, index) {
                              bool? checkVal = false;
                              tpCheckList.add(checkVal);
                              return CheckboxListTile(
                                title: Text(transportations[index]),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (value) => setState(() {
                                  tpCheckList[index] = value;
                                }),
                                value: tpCheckList[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    //!!!!!!!!!!!!!!!!WORK CATEGORY!!!!!!!!!!!!!!!!!!!
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(width: 80, child: Text("가능한 심부름")),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              bool? checkVal = false;
                              wcCheckList.add(checkVal);
                              return CheckboxListTile(
                                title: Text(categories[index]),
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (value) => setState(() {
                                  wcCheckList[index] = value;
                                }),
                                value: wcCheckList[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.7), spreadRadius: 0, blurRadius: 5, offset: Offset(0, 1)),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              onPressed: () {
                _showModalBottom();
              },
              minWidth: double.maxFinite,
              color: Colors.orange,
              child: const Text(
                "드림이 등록 요청",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalBottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (_checkAll == true) {
              for (bool check in _termsCheck) {}
            }
            return Wrap(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "약관 동의",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: CheckboxListTile(
                      value: _checkAll,
                      onChanged: (bool? value) {
                        setState(() {
                          _checkAll = value!;
                          if (_checkAll) {
                            for (int i = 0; i < _termsCheck.length; i++) {
                              _termsCheck[i] = true;
                            }
                            _isDisable = false;
                          } else {
                            for (int i = 0; i < _termsCheck.length; i++) {
                              _termsCheck[i] = false;
                            }
                            _isDisable = true;
                          }
                        });
                      },
                      title: const Text("모든 약관 동의하기")),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _termsName.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: _termsCheck[index],
                        onChanged: (value) {
                          setState(() {
                            if (!value!) {
                              _checkAll = false;
                            }
                            _termsCheck[index] = value;

                            bool isButtonClickAble = true;
                            for (bool b in _termsCheck) {
                              if (b) {
                                isButtonClickAble = false;
                              } else {
                                isButtonClickAble = true;
                                break;
                              }
                            }
                            _isDisable = isButtonClickAble;
                          });
                        },
                        title: Text(_termsName[index]),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      disabledForegroundColor: Colors.grey,
                    ),
                    onPressed: _isDisable
                        ? null
                        : () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("작성한 내용으로 드림이 지원하시겠습니까?"),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      String transportation = "";
                                      for (int i = 0; i < tpCheckList.length; i++) {
                                        if (tpCheckList[i] == true) {
                                          transportation += "${transportations[i]},";
                                        }
                                      }
                                      if (transportation != "") {
                                        transportation = transportation.substring(0, transportation.length - 1);
                                      }

                                      String category = "";
                                      for (int i = 0; i < wcCheckList.length; i++) {
                                        if (wcCheckList[i] == true) {
                                          category += "${categories[i]},";
                                        }
                                      }
                                      if (category != "") {
                                        category = category.substring(0, category.length - 1);
                                      }

                                      List<String> _infs = widget.infs;
                                      _infs.add(_introduceController.text.trim());
                                      _infs.add(transportation);
                                      _infs.add(category);

                                      await _viewModel.onUsersEvent(
                                          UsersEvent.workerRegistration1(_state.user!.idx.toString(), widget.idCardPath, widget.faceCheckPath, _infs));
                                      await _viewModel
                                          .onUsersEvent(UsersEvent.workerRegistration(_state.user!.idx.toString()))
                                          .then((value) => Navigator.popUntil(context, (route) => route.isFirst));

                                      // _viewModel
                                      //     .onUsersEvent(UsersEvent.workerRegistration(_state.user!.idx.toString()))
                                      //     .then((value) => Navigator.popUntil(context, (route) => route.isFirst));
                                    },
                                    child: const Text(
                                      "지원",
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "취소",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ).then((value) => null),
                    child: const Text(
                      "동의하기",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        );
      },
    );
  }


}
