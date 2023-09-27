import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:test_project/screen/mypage/announcement_detail_page.dart';

import '../../domain/model/user/announcement.dart';
/*
class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final announcementState = viewModel.announcementState;
    // viewModel.onUsersEvent(UsersEvent.getAnnouncement());
    final List<String> announcementTypeTab = <String>['공지사항', 'FAQ', '이벤트'];
    List<Announcement> tappedList = announcementState.announcements[0];

    return DefaultTabController(
      length: announcementTypeTab.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('공지사항'),
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: announcementTypeTab
                        .map((String type) => Tab(text: type))
                        .toList(),
                    onTap: (tapIndex) {
                      switch (tapIndex) {
                        case 0:
                          tappedList = announcementState.announcements[0];
                          break;
                        case 1:
                          tappedList = announcementState.announcements[1];
                          break;
                        case 2:
                          tappedList = announcementState.announcements[2];
                          break;
                      }
                    },
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: announcementTypeTab.map((String type) {
              return SafeArea(
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      key: PageStorageKey<String>(type),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              final curAnnouncements = tappedList[index];
                              return GestureDetector(
                                child: Card(
                                  child: ListTile(
                                    title: Text('${curAnnouncements.title}'),
                                    subtitle: Text('${curAnnouncements.announceAt.substring(0, 10)}'),
                                  ),
                                ),
                                onTap: () {
                                  Logger().d('on tile tapped!');
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Text(curAnnouncements.content),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            childCount: tappedList.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          )
        ),
      ),
    );
  }
}*/

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final announcementState = viewModel.announcementState;
    final List<String> announcementTypeTab = <String>['공지사항', 'FAQ', '이벤트'];

    return DefaultTabController(
      length: announcementTypeTab.length,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text('공지사항'),
                    pinned: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: announcementTypeTab
                          .map((String type) => Tab(text: type))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                buildListView(announcementState.announcements[0], viewModel),
                buildListView(announcementState.announcements[1], viewModel),
                buildListView(announcementState.announcements[2], viewModel)
              ],
            )),
      ),
    );
  }

  Widget buildListView(List<Announcement> tappedList, UserViewModel viewModel) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            // key: PageStorageKey<String>(type),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final curAnnouncements = tappedList[index];
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,),
                        child: Card(
                          child: ListTile(
                            title: Text(curAnnouncements.title),
                            subtitle: Text(
                                curAnnouncements.announceAt.substring(0, 10)),
                          ),
                        ),
                      ),
                      onTap: () {
                        viewModel
                            .onUsersEvent(UsersEvent.getAnnouncementByIdx(
                                curAnnouncements.idx))
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnnouncementDetailPage())));
                      },
                    );
                  },
                  childCount: tappedList.length,
                ),
              ),
            ],
          );
          // 여기서 tappedList 를 사용하세요.
        }));
  }
}
