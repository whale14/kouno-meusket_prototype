import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LookAround extends StatefulWidget {
  final String userId;

  const LookAround(this.userId, {Key? key}) : super(key: key);

  @override
  State<LookAround> createState() => _LookAroundState();
}

class _LookAroundState extends State<LookAround> {
  var categories = ["배달/구매 대행", "청소/가사 도움", "운반/수리", "동행/돌봄", "단기 알바", "기타"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appBarLA(),
            walletContainer(),
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Colors.orange),
              child: Text("광고광고"),
            ),
            workContainer(),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.orange),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('미어켓은 안전합니다.', style: TextStyle(fontSize: 24),),
                  SizedBox(height: 20,),
                  Text('1. 부름이와 드림이들의 철저한 신원 인증'),
                  Text('2. 전문가들의 자격증 진위여부 확인'),
                  Text('3. 신뢰할만한 신원 인증 시스템'),

                ],
              ),
            ),
            footer()
          ],
        ),
      ),
    );
  }

  Widget appBarLA() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {},
      ),
      title: const Text(
        "LOGO",
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            "마이페이지",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }

  Widget walletContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.person_crop_circle,
                  size: 44,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "아이디",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "내지갑 >",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "10000원",
                  style: TextStyle(fontSize: 24),
                ),
                Text("100 coin"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget workContainer() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Expanded(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text("미어켓만의 특별한 서비스")),
                TextButton(
                  onPressed: () {},
                  child: Text("전체보기"),
                )
              ],
            ),
            GridView.builder(
              primary: false,
              itemCount: categories.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            child: Text("image"),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabPage(widget.userId, categories[index]),
                              ))),
                      Text(categories[index])
                    ],
                  ),
                );
              },
            )
          ],
        ),
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
          Text("고객센터", style: TextStyle(fontSize: 24),),
          SizedBox(height: 20,),
          Row(children: [
            Expanded(child: Text("카카오톡 문의 하기")),
            Expanded(child: Text("카카오톡 채널")),
          ],),
          Row(children: [
            Expanded(child: Text("이메일 문의 하기")),
            Expanded(child: Text("help@meusket.com")),
          ],),
          Row(children: [
            Expanded(child: Text("상담/문의 시간")),
            Expanded(child: Text("10:00 ~ 17:00")),
          ],)
        ],
      ),
    );
  }
}
