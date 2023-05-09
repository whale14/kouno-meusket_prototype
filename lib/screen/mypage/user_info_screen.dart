import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_project/screen/mypage/update_user_info.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;

  const UserInfoScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> with TickerProviderStateMixin {
  late User _user;
  late UserViewModel _viewModel;
  late UserState _state;

  late Future initialize;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    initialize = _initialize();
  }

  Future _initialize() async {
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserViewModel>();
    _state = _viewModel.userState;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          infoHeader(_user),
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("소개"),
              ),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("사진"),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (true) const Text("자기소개", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) else Row(),
                            SizedBox(height: 30),
                            Text("소개소개소개 렛미 인트로듀스 마셆")
                          ],
                        ),
                      ),//자기소개
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (true)
                              Row(
                                children: [
                                  Text("이동수단", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(left: 10),
                                            decoration:
                                                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                            child: Text(
                                              "도보",
                                              style: TextStyle(color: Colors.black45),
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(left: 10),
                                            decoration:
                                                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                            child: Text(
                                              "자전거",
                                              style: TextStyle(color: Colors.black45),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(),
                          ],
                        ),
                      ),//이동수단
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (true) const Text("심부름 가능 항목", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) else Row(),
                            SizedBox(height: 30),
                            Text("리스트")
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (true) const Text("자격증", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) else Row(),
                            SizedBox(height: 30),
                            Text("자격증")
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text("사진"),
                  ),
                ],
              ),
            ),
          )
          // Container(
          //   padding: EdgeInsets.only(top: 15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Expanded(
          //         child: InkWell(
          //           child: Container(
          //             alignment: Alignment.center,
          //             padding: EdgeInsets.only(bottom: 15),
          //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
          //             child: Text("부름이 소개"),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: InkWell(
          //           child: Container(
          //             alignment: Alignment.center,
          //             padding: EdgeInsets.only(bottom: 15),
          //             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
          //             child: Text("드림이 소개"),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget infoHeader(User user) => Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  "요청건",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  "수행건",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("bio(한줄소개)"),
                  MaterialButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserInfo(),)),
                      color: Colors.orange,
                      child: Container(alignment: Alignment.center, width: double.maxFinite, child: const Text("회원정보 수정")))
                ],
              ),
            )
          ],
        ),
      );
}
