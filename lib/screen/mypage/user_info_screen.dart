import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/request/request_review.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/presentation/event/request_review/request_review_event.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/request/request_review_state.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/review_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/mypage/update_user_info.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> with TickerProviderStateMixin {
  late UserViewModel _userViewModel;
  late UserState _userState;
  late OtherUserState _otherUserState;

  late ReviewViewModel _reviewViewModel;
  late RequestReviewState _reviewState;

  late Future initialize;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getReviews();
      Logger().d("####################reviews : ${_reviewState.requestReviews.toString()}");
    });
  }

  Future getReviews() async {
    await _reviewViewModel.onReviewEvent(RequestReviewEvent.getReviews(_otherUserState.user!.idx.toString()));
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;
    _otherUserState = _userViewModel.otherUserState;

    _reviewViewModel = context.watch<ReviewViewModel>();
    _reviewState = _reviewViewModel.reviewState;

    int requestReviewCount = 0;
    int workReviewCount = 0;
    for (var review in _reviewState.requestReviews) {
      review.isRequester == _otherUserState.user!.idx ? requestReviewCount++ : workReviewCount++;
    }
    List<String> transportations = [];
    List<String> categories = [];
    if (_otherUserState.user!.transportation != null && _otherUserState.user!.transportation != "") {
      transportations = _otherUserState.user!.transportation!.split(",");
    }

    if (_otherUserState.user!.workCategory != null && _otherUserState.user!.workCategory != "") {
      categories = _otherUserState.user!.workCategory!.split(",");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("회원정보"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_otherUserState.user!.profileImageUrl == null)
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
                                    "http://${_otherUserState.user!.profileImageUrl}",
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
                                        "${_otherUserState.user!.requestRequesterCount}",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      const Text(
                                        "요청건",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${_otherUserState.user!.requestWorkerCount}",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      const Text(
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
                          _otherUserState.user!.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (_otherUserState.user!.bio != null) Text(_otherUserState.user!.bio!),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: transportations
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration:
                                    BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: Color(0xffF8A239))),
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.black45),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: categories
                            .map(
                              (e) => Container(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.grey),
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_otherUserState.user!.idx == _userState.user!.idx)
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                  padding: const EdgeInsets.all(16),
                  child: MaterialButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateUserInfo(),
                      ),
                    ),
                    color: Colors.black87,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: const Text(
                        "회원정보 수정",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: const Text("소개"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("요청 리뷰 $requestReviewCount"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("수행 리뷰 $workReviewCount"),
                        ),
                      ],
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
            if (_otherUserState.user!.isWorkerRegist == 1)
              Container()
            /*SafeArea(
                top: false,
                bottom: false,
                child: Builder(builder: (context) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("자기소개", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              if (_userState.user!.introduce != null) Text(_userState.user!.introduce!),
                            ],
                          ),
                        ), //자기소개
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("이동수단", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        for (String transportation in transportations) ...[
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: Colors.black45)),
                                            child: Text(
                                              transportation,
                                              style: const TextStyle(color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                )
                              else
                                const Row(),
                            ],
                          ),
                        ), //이동수단
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("심부름 가능 항목", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 20),
                              for (String category in categories) ...[
                                ListTile(
                                  title: Text(category),
                                )
                              ]
                            ],
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 10))),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (true) Text("자격증", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)) else const Row(),
                              SizedBox(height: 20),
                              Text("자격증")
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )*/
            else
              const Center(child: Text("부름이 등록후 작성 가능합니다.")),
            ListView.builder(
              itemCount: _reviewState.requestReviews.length,
              itemBuilder: (context, index) {
                final review = _reviewState.requestReviews[index];
                Logger().d(review.toString());

                return review.isRequester == _otherUserState.user!.idx ? reviewBox(review) : null;
              },
            ),
            ListView.builder(
              itemCount: _reviewState.requestReviews.length,
              itemBuilder: (context, index) {
                final review = _reviewState.requestReviews[index];
                Logger().d(review.toString());

                return review.isRequester != _otherUserState.user!.idx ? reviewBox(review) : null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewBox(RequestReview review) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE9E9E9)))),
      child: Row(
        children: [
          ClipOval(
              child: Image.network(
            "http://${review.reviewerImageUrl}",
            cacheWidth: 1080,
            height: 60,
          )),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                itemSize: 24,
                ignoreGestures: true,
                itemBuilder: (BuildContext context, int index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {},
                initialRating: review.score,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                review.reviewerName,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(review.comment),
            ],
          )
        ],
      ),
    );
  }
}
