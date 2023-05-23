import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/mypage/update_user_info.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> with TickerProviderStateMixin {
  late UserViewModel _viewModel;
  late UserState _state;

  late Future initialize;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserViewModel>();
    _state = _viewModel.userState;

    List<String> transportations = [];
    List<String> categories = [];
    if (_state.user!.transportation != null && _state.user!.transportation != "") {
      transportations = _state.user!.transportation!.split(",");
    }

    if (_state.user!.workCategory != null && _state.user!.workCategory != "") {
      categories = _state.user!.workCategory!.split(",");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("회원정보"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_state.user!.profileImageUrl == null)
                              const Icon(Icons.person, size: 88)
                            else
                              Container(
                                width: 88,
                                height: 88,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1, color: Colors.orange),
                                ),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                      child: Image.network(
                                    "http://${_state.user!.profileImageUrl}",
                                    cacheWidth: 1080,
                                  )),
                                ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _state.user!.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (_state.user!.bio != null) Text(_state.user!.bio!),
                        MaterialButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UpdateUserInfo(),
                                )),
                            color: Colors.orange,
                            child: Container(
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                child: const Text(
                                  "회원정보 수정",
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                child: TabBar(
                  controller: _tabController,
                  tabs: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: const Text("소개"),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: const Text("사진"),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            if (_state.user!.isWorkerRegist == 1)
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (context) {
                    return SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("자기소개", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 20),
                                if (_state.user!.introduce != null) Text(_state.user!.introduce!),
                              ],
                            ),
                          ), //자기소개
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (true)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("이동수단", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          for (String transportation in transportations) ...[
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                              child: Text(
                                                transportation,
                                                style: TextStyle(color: Colors.black45),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  Row(),
                              ],
                            ),
                          ), //이동수단
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("심부름 가능 항목", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 20),
                                for(String category in categories)...[
                                  ListTile(title: Text(category),)
                                ]
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
                                SizedBox(height: 20),
                                Text("자격증")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              )
            else
              const Center(child: Text("부름이 등록후 작성 가능합니다.")),
            Center(
              child: Text("사진"),
            ),
          ],
        ),
      ),
      /*Column(
        children: [
          // infoHeader(_state.user!),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_state.user!.profileImageUrl == null)
                          const Icon(Icons.person, size: 88)
                        else
                          Container(
                            width: 88,
                            height: 88,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.orange),
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                  child: Image.network(
                                "http://${_state.user!.profileImageUrl}",
                                cacheWidth: 1080,
                              )),
                            ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _state.user!.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (_state.user!.bio != null) Text(_state.user!.bio!),
                    MaterialButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateUserInfo(),
                            )),
                        color: Colors.orange,
                        child: Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            child: const Text(
                              "회원정보 수정",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
              )
            ],
          ),
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: const Text("소개"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: const Text("사진"),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  if (_state.user!.isWorkerRegist == 1)
                    Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("자기소개", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20),
                              if (_state.user!.introduce != null) Text(_state.user!.introduce!),
                            ],
                          ),
                        ), //자기소개
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("이동수단", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (String transportation in transportations) ...[
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration:
                                                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                            child: Text(
                                              transportation,
                                              style: TextStyle(color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                )
                              else
                                Row(),
                            ],
                          ),
                        ), //이동수단
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
                    )
                  else
                    const Center(child: Text("부름이 등록후 작성 가능합니다.")),
                  Center(
                    child: Text("사진"),
                  ),
                ],
              ),
            ),
          ),
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
      ),*/
    );
  }

  /* Widget infoHeader(User user) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (user.profileImageUrl == null)
                      const Icon(Icons.person, size: 88)
                    else
                      Container(
                        width: 88,
                        height: 88,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.orange),
                        ),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage("http://${user.profileImageUrl}"), fit: BoxFit.cover),
                          ),
                        ),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("bio(한줄소개)"),
                MaterialButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateUserInfo(),
                        )),
                    color: Colors.orange,
                    child: Container(alignment: Alignment.center, width: double.maxFinite, child: const Text("회원정보 수정")))
              ],
            ),
          )
        ],
      ),
    );
  } */
}
