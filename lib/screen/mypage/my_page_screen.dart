import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/mypage/user_info_screen.dart';

class MyPageScreen extends StatelessWidget {
  final List<String> tabsString = [
    "수익금 관리",
    "결제 수단 관리",
    "심부름 내역 관리",
    "포인트/쿠폰확인",
    "공지사항",
    "문의하기",
  ];

  MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    var state = viewModel.userState;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "마이페이지",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UserInfoScreen())),
            child: accountContainer(state),
          ),
          for (var element in tabsString) ...[
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [Expanded(child: Text(element)), const Icon(Icons.chevron_right)],
              ),
            )
          ],
        ],
      ),
    );
  }

  accountContainer(UserState state) {
    User user = state.user!;
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 12))),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (user.profileImageUrl == null)
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.orange, width: 2.5))),
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                    ),
                  )
                else
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.orange),
                    ),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                          child: Image.network(
                        "http://${user.profileImageUrl}",
                        cacheWidth: 1080,
                      )),
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                Text(user.name),
              ],
            ),
          ),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "고객센터",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(child: Text("카카오톡 문의 하기")),
              Expanded(child: Text("카카오톡 채널")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("이메일 문의 하기")),
              Expanded(child: Text("help@meusket.com")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("상담/문의 시간")),
              Expanded(child: Text("10:00 ~ 17:00")),
            ],
          )
        ],
      ),
    );
  }
}
