import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/domain/repository/user_repository.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/users/wallet_state.dart';

class UserViewModel with ChangeNotifier {
  // final TestRepository _testRepository;
  // var _testState = TestState();
  final UserRepository _userRepository;
  var _usersState = UsersState();
  var _userState = UserState();
  var _otherUserState = OtherUserState();
  var _walletState = WalletState();

  // TestState get testState => _testState;
  UserState get userState => _userState;

  UsersState get usersState => _usersState;

  OtherUserState get otherUserState => _otherUserState;

  WalletState get walletState => _walletState;

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
      updateUserPhoto: _updateUserPhoto,
      updateUserName: _updateUserName,
      updateUserBio: _updateUserBio,
      updateUserIntroduce: _updateUserIntroduce,
      updateUserTransportation: _updateUserTransportation,
      updateUserWorkCategory: _updateUserWorkCategory,
      workerRegistration1: _workerRegistration1,
      getOtherUser: _getOtherUser,
      sendRequestToWorker: _sendRequestToWorker,
      updateWorkableState:  _updateWorkableState,
      updateNotWorkableState: _updateNotWorkableState,
      myWallet: _myWallet,
    );
  }

  Future _insert(String id, String name, String bio, double latitude, double longitude, String fcmToken) async {
    Logger().d("vm data: $id");
    await _userRepository.insert(id, name, bio, latitude, longitude, fcmToken);
  }

  Future _getAroundHelpers(String idx, List<bool> categoryCheckValues, List<bool>ageCheckValues, List<bool> genderCheckValues, int distance) async {
    _usersState = usersState.copyWith(isLoading: true);
    notifyListeners();

    Logger().d("vm data: $idx");
    final result = _userRepository.getAroundHelpers(idx, categoryCheckValues, ageCheckValues, genderCheckValues, distance);

    _usersState = usersState.copyWith(
      isLoading: false,
      users: await result,
    );
    notifyListeners();
    Logger().d("vm(users): ${await result}");

    // return result;
  }

  Future _insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String date, String runningTime, String reward, List<Map<String, dynamic>> waypointLocation, List<String> waypointContent, int requestType, int secondType) async {
    await _userRepository.insertRequest(reqIdx, categoryIdx, title, content, address, latitude, longitude, date, runningTime, reward, waypointLocation, waypointContent, requestType, secondType);
  }

  Future _getUser(String id) async {
    _userState = userState.copyWith(isLoading: true);
    notifyListeners();

    final result = await _userRepository.getUser(id);
    Logger().d("vm(user):$result");

    _userState = userState.copyWith(
      isLoading: false,
      user: result,
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

  Future _updateUserPhoto(String idx, String fileName) async {
    await _userRepository.updateUserInfo(idx, fileName);
  }

  Future _updateUserName(String idx, String name) async {
    await _userRepository.updateUserName(idx, name);
  }

  Future _updateUserBio(String idx, String bio) async {
    await _userRepository.updateUserBio(idx, bio);
  }

  Future _updateUserIntroduce(String idx, String introduce) async {
    await _userRepository.updateUserIntroduce(idx, introduce);
  }

  Future _updateUserTransportation(String idx, String transportation) async {
    await _userRepository.updateUserTransportation(idx, transportation);
  }

  Future _updateUserWorkCategory(String idx, String workCategory) async {
    await _userRepository.updateUserWorkCategory(idx, workCategory);
  }

  Future _workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs) async {
    await _userRepository.workerRegistration1(idx, idCardPath, faceCheckPath, infs);
  }

  Future _getOtherUser(String tappedWorkerIdx) async{
    final result = _userRepository.getUserFromIdx(tappedWorkerIdx);

    _otherUserState = otherUserState.copyWith(user: await result);
    notifyListeners();
  }

  Future _sendRequestToWorker(String reqIdx,String workerIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude,String date, String runningTime, String reword, List<Map<String, dynamic>> waypointsLocation, List<String> waypointsContent, String fcmToken, int requestType, int secondType) async{
    await _userRepository.sendRequestToWorker(reqIdx, workerIdx, categoryIdx, title, content, address, latitude, longitude, date, runningTime, reword, waypointsLocation, waypointsContent, fcmToken, requestType, secondType);
  }

  Future _updateWorkableState(String idx) async{
    await _userRepository.updateWorkableState(idx);

    final result = _userRepository.getUserFromIdx(idx);
    _userState = userState.copyWith(user: await result);

    notifyListeners();
  }

  Future _updateNotWorkableState(String idx) async{
    await _userRepository.updateNotWorkableState(idx);

    final result = _userRepository.getUserFromIdx(idx);
    _userState = userState.copyWith(user: await result);

    notifyListeners();
  }

  Future<bool> _checkId(id) async{
    return _userRepository.checkId(id);
  }

  Future _myWallet(String idx) async{
    final result = _userRepository.myWallet(idx);
    _walletState = walletState.copyWith(wallet: await result);
    notifyListeners();
  }
}
