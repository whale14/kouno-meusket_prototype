import 'package:flutter/material.dart';
import 'package:test_project/domain/model/user/users.dart';
import 'package:test_project/screen/mypage/user_info_screen.dart';

class MyPageScreen extends StatelessWidget {
  final Users user;
  final List<String> tabsString = [
    "수익금 관리",
    "결제 수단 관리",
    "심부름 내역 관리",
    "포인트/쿠폰확인",
    "공지사항",
    "문의하기",
  ];

  MyPageScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "마이페이지",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen(user))),
            child: accountContainer(),),
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

  accountContainer() {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 12))),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.orange, width: 2.5))),
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                  ),
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
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
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
