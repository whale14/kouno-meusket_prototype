import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/domain/model/request/request.dart';
import 'package:test_project/domain/model/user/user.dart';
import 'package:test_project/domain/model/work_category.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/errand_history/work_info_page.dart';

class BodyHelper extends StatefulWidget {
  final User user;

  const BodyHelper(this.user, {Key? key}) : super(key: key);

  @override
  State<BodyHelper> createState() => _BodyHelperState();
}

class _BodyHelperState extends State<BodyHelper> {
  late RequestViewModel _requestViewModel;
  late RequestState _requestState;
  late UserViewModel _userViewModel;
  late UserState _userState;

  // late Future initialize;

  Future _initialize() async {
    try {
      Logger().d("workMain initialize");
      await _requestViewModel.onRequestEvent(RequestEvent.getRequests(_userState.user!.idx.toString()));
    } catch (e) {
      Logger().d("error -> ${e.toString()}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initialize();
    });
    // initialize = _initialize();
  }

  @override
  Widget build(BuildContext context) {
    _requestViewModel = context.watch<RequestViewModel>();
    _requestState = _requestViewModel.requestState;
    _userViewModel = context.watch<UserViewModel>();
    _userState = _userViewModel.userState;

    Logger().d("doingState : ${_userState.user!.doingState}");
    Logger().d("rebuild..");

    return Scaffold(
      appBar: AppBar(
        title: const Text("드림이"),
      ),
      body: _userState.user!.accountState == 0
          ? Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("드림이 활동 여부"),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_userState.user!.doingState == 0) {
                          _userViewModel.onUsersEvent(UsersEvent.updateWorkableState(_userState.user!.idx.toString()));
                        } else {
                          _userViewModel.onUsersEvent(UsersEvent.updateNotWorkableState(_userState.user!.idx.toString()));
                        }
                      },
                      child: doingButton(_userState.user!),
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    itemCount: _requestState.requests.length,
                    itemBuilder: (context, index) {
                      final request = _requestState.requests[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WorkInfoPage(request, 1),
                        )),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.only(top: 16),
                          elevation: 4,
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          request.title,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(WorkCategory().categories[request.workCategoryIdx]),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(request.address),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${DateFormat("yyyy-MM-dd").format(request.workDate!)} "
                                      "${request.workDate!.hour >= 12 ? '오후 ' : '오전 '}"
                                      "${request.workDate!.hour >= 13 ? request.workDate!.hour - 12 : request.workDate!.hour}시"
                                      "${request.workDate!.minute != 0 ? '${request.workDate!.minute}분' : ''}",
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        const Text("심부름비"),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text("${request.reward.toString()}원"),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 54,
                                        height: 54,
                                        decoration: const BoxDecoration(shape: BoxShape.circle),
                                        child: ClipOval(
                                          child: Image.network(
                                            "http://${request.requesterImgUrl}",
                                            cacheWidth: 1080,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(request.requesterName)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text('회원님의 계정이 차단상태입니다.'),
            ),
    );
  }

  Widget doingButton(User user) {
    if (user.doingState == 0) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xff999999), Color(0xffD1D1D1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xffD1D1D1), Color(0xff999999)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Text(
            "활동중",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xffEB8229), Color(0xffF8A239)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xffF8A239), Color(0xffEB8229)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Text(
            "활동중",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
