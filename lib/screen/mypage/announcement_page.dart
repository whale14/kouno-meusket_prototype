import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

import '../../domain/model/user/announcement.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final announcementState = viewModel.announcementState;
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
                      switch(tapIndex) {
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
                      key: PageStorageKey<String>(type),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context)),
                        SliverFixedExtentList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                final curAnnouncements = tappedList[index];
                                return ListTile(
                                  title: Text('$curAnnouncements.title'),
                                );
                              },
                              childCount: tappedList.length,
                            ),
                            itemExtent: 48.0)
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/*
class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final announcementState = viewModel.announcementState;
    final List<String> announcementTypeTab = <String>['공지사항', 'FAQ', '이벤트'];
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
                          .toList()),
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
                      key: PageStorageKey<String>(type),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                            handle:
                            NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context)),
                        SliverFixedExtentList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {

                                return ListTile(
                                  title: Text('공지 $index'),
                                );
                              },
                            ),
                            itemExtent: 48.0)
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
*/
