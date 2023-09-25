import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';

class AnnouncementDetailPage extends StatelessWidget {
  const AnnouncementDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final announcementState = viewModel.announcementState;
    final List<String> announcementTypeTab = <String>['공지사항', 'FAQ', '이벤트'];
    return Scaffold(
      appBar: AppBar(
        title: announcementState.isLoading
            ? const Text('')
            : Text(_getTypeText(announcementState.announcement!.type)),
      ),
      body: announcementState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcementState.announcement!.title,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                    ),
                  ),
                  Text(
                    announcementState.announcement!.announceAt,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(),
                  const SizedBox(height: 20.0),
                  Text(
                    announcementState.announcement!.content,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('돌아가기')))
                ],
              ),
            )),
    );
  }
}

String _getTypeText(String type) {
  switch (type) {
    case 'system':
      return '공지사항';
    case 'FAQ':
      return 'FAQ';
    case 'event':
      return '이벤트';
    default:
      return ''; // 다른 경우에 대한 기본값 설정
  }
}
