import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/domain/repository/user_repository.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/event/users/users_event.dart';

class UserViewModel with ChangeNotifier {
  // final TestRepository _testRepository;
  // var _testState = TestState();
  final UserRepository _userRepository;
  var _usersState = UsersState();
  var _userState = UserState();

  // TestState get testState => _testState;
  UserState get userState => _userState;

  UsersState get usersState => _usersState;

  UserViewModel(this._userRepository);

  Future onUsersEvent(UsersEvent event) async {
    // event.when(getTests: _getTests);
    await event.when(
        getAroundHelpers: _getAroundHelpers,
        insert: _insert,
        insertRequest: _insertRequest,
        getUser: _getUser,
        updateLocation: _updateLocation,
        requesterRegistration: _requesterRegistration,
        workerRegistration: _workerRegistration,
        updateUserInfo: _updateUserInfo);
  }

  Future _insert(String id, String name, double latitude, double longitude) async {
    Logger().d("vm data: $id");
    await _userRepository.insert(id, name, latitude, longitude);
  }

  Future _getAroundHelpers(String id) async {
    _usersState = usersState.copyWith(isLoading: true);
    notifyListeners();

    final result = _userRepository.getAroundHelpers();
    final idx = _userRepository.getMyIdx(id);

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
    await _userRepository.insertRequest(reqIdx, categoryIdx, title, content, address, latitude, longitude);
  }

  Future _getUser(String id) async {
    _userState = userState.copyWith(isLoading: true);
    notifyListeners();

    final result = _userRepository.getUser(id);
    Logger().d("vm(user):$result");

    _userState = userState.copyWith(
      isLoading: false,
      user: await result,
    );
    notifyListeners();
  }

  Future _updateLocation(String idx, double latitude, double longitude) async {
    await _userRepository.updateLocation(idx, latitude, longitude);
  }

  Future _requesterRegistration(String idx) async {
    await _userRepository.requestRegistration(idx);
    final result = _userRepository.getUserFromIdx(idx);

    _userState = userState.copyWith(user: await result);
    notifyListeners();
  }

  Future _workerRegistration(String idx) async {
    await _userRepository.workerRegistration(idx);
    final result = _userRepository.getUserFromIdx(idx);

    _userState = userState.copyWith(user: await result);
    notifyListeners();
  }

  Future _updateUserInfo(String idx, String fileName) async {
    await _userRepository.updateUserInfo(idx, fileName);

    final result = _userRepository.getUserFromIdx(idx);

    _userState = userState.copyWith(user: await result);
    notifyListeners();
  }
}
