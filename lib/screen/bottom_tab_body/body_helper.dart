import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/presentation/event/request/request_event.dart';
import 'package:test_project/presentation/state/request/request_state.dart';
import 'package:test_project/presentation/vm/request_view_model.dart';


class BodyHelper extends StatefulWidget {
  const BodyHelper({Key? key}) : super(key: key);

  @override
  State<BodyHelper> createState() => _BodyHelperState();
}

class _BodyHelperState extends State<BodyHelper> {
  late RequestViewModel _viewModel;
  late RequestState _state;
  String? myIdx = '';
  late Future initialize;

  Future _getMyIdx() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myIdx = prefs.getString('idx');
    Logger().d('!!!!!!!!!!!!!!!!!!!!$myIdx');
  }

  Future _initialize() async{
    await _getMyIdx();
    await _viewModel.onRequestEvent(RequestEvent.getRequests(myIdx!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialize = _initialize();

  }
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<RequestViewModel>();
    _state = _viewModel.requestState;

    return FutureBuilder(
      future: initialize,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          Logger().d(_state.requests);
          return ListView.builder(
          itemCount: _state.requests.length,
          itemBuilder: (context, index) {
            final request = _state.requests[index];
            return GestureDetector(
              onTap: () {
                Logger().d('title tapped');
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text(request.title),
                    content: Column(children: [
                      Row(children: [
                        const Text("content : "),
                        Text(request.content)
                      ],),
                      Row(children: [
                        const Text("address : "),
                        Text(request.address)
                      ],),
                      Row(children: [
                        const Text("reward : "),
                        Text(request.reward.toString())
                      ],),
                    ],),
                    actions: [
                      TextButton(onPressed: () {
                        _viewModel.onRequestEvent(RequestEvent.acceptRequest(request.idx.toString(), myIdx!));
                      }, child: const Text('accept')),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text('back')),
                    ],
                  );
                },);
              },
              child: ListTile(
                title: Text(request.title),
                subtitle: Text(request.content),
              ),
            );
          },
        );
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}
