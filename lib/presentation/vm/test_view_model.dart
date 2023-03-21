// import 'package:test_project/domain/repository/test_repository.dart';
// import 'package:test_project/presentation/state/test_state.dart';
// import 'package:test_project/presentation/event/test_event.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:test_project/domain/model/users/users.dart';
import 'package:test_project/domain/repository/errand_repository.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/event/users/users_event.dart';

import '../event/users/user_event.dart';
import '../state/users/user_state.dart';

class TestViewModel with ChangeNotifier {
  // final TestRepository _testRepository;
  // var _testState = TestState();
  final ErrandRepository _errandRepository;
  var _usersState = UsersState();
  var _userState = UserState();

  // TestState get testState => _testState;
  UsersState get usersState => _usersState;
  UserState get userState => _userState;

  TestViewModel(this._errandRepository) {
    // _getTests();
    // _getAroundHelpers();
  }

  // Future<void> _getTests() async {
  //   _testState = testState.copyWith(isLoading: true);
  //   notifyListeners();
  //   final result = await _testRepository.getTests();
  //
  //   _testState = testState.copyWith(
  //     isLoading: false,
  //     tests: result,
  //   );
  //   notifyListeners();
  // }

  Future onUsersEvent(UsersEvent event) async{
    // event.when(getTests: _getTests);
    await event.when(getAroundHelpers: _getAroundHelpers, insert: _insert, insertRequest: _insertRequest);
  }

  Future onUserEvent(UserEvent event) async{
    await event.when(getUser: _getUser, updateLocation: _updateLocation);
  }


  Future _insert(String id, String name, double latitude, double longitude) async {
    Logger().d("vm data: $id");
    await _errandRepository.insert(id, name, latitude, longitude);
  }

  Future _getAroundHelpers(String id) async {
    _usersState = usersState.copyWith(isLoading: true);
    notifyListeners();

    final result = _errandRepository.getAroundHelpers();
    final idx = _errandRepository.getMyIdx(id);

    _usersState = usersState.copyWith(
      isLoading: false,
      users: await result,
      myIdx: await idx,
    );
    notifyListeners();
    Logger().d("vm(users):$result");

    // return result;
  }

  Future _insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude) async {
    await _errandRepository.insertRequest(reqIdx, categoryIdx, title, content, address, latitude, longitude);
  }

  Future _getUser(String id) async {
    _userState = userState.copyWith(isLoading: true);
    notifyListeners();

    final result = _errandRepository.getUser(id);
    Logger().d("vm(user):$result");

    _userState = userState.copyWith(
      isLoading: false,
      user: await result,
    );
    notifyListeners();
  }

  Future _updateLocation(String idx, double latitude, double longitude) async{
    await _errandRepository.updateLocation(idx, latitude, longitude);
  }
}
