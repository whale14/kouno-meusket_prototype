import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:test_project/domain/model/user/users.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/vm/user_view_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserInfoScreen extends StatefulWidget {
  final Users user;

  const UserInfoScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late Users _user;
  late UserViewModel _viewModel;
  late UserState _state;

  late Future initialize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize = _initialize();
  }

  Future _initialize() async {
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserViewModel>();
    _state = _viewModel.userState;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(_user.name),
                            SizedBox(
                              width: 10,
                            ),
                            Text("20대 후반")
                          ],
                        ),
                        RatingBar.builder(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          onRatingUpdate: (value) => Logger().d(value),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
