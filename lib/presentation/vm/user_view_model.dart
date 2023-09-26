import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:test_project/domain/repository/user_repository.dart';
import 'package:test_project/presentation/state/users/announcement_state.dart';
import 'package:test_project/presentation/state/users/other_user_state.dart';
import 'package:test_project/presentation/state/users/user_state.dart';
import 'package:test_project/presentation/state/users/users_state.dart';
import 'package:test_project/presentation/event/users/users_event.dart';
import 'package:test_project/presentation/state/wallet/wallet_state.dart';

class UserViewModel with ChangeNotifier {
  // final TestRepository _testRepository;
  // var _testState = TestState();
  final UserRepository _userRepository;
  var _usersState = UsersState();
  var _userState = UserState();
  var _otherUserState = OtherUserState();
  // var _walletState = WalletState();
  var _announcementState = AnnouncementState();

  // TestState get testState => _testState;
  UserState get userState => _userState;

  UsersState get usersState => _usersState;

  OtherUserState get otherUserState => _otherUserState;

  // WalletState get walletState => _walletState;

  AnnouncementState get announcementState => _announcementState;

  UserViewModel(this._userRepository) {
    _getAnnouncement();
  }

  Future onUsersEvent(UsersEvent event) async {
    // event.when(getTests: _getTests);


    switch(event) {
    case GetAroundHelpers(): _getAroundHelpers(event.id, event.workCategoryCheckValues, event.ageGroupCheckValues, event.genderCheckValues, event.distanceIndex);
    case Insert(): _insert(event.id, event.name, event.bio, event.latitude, event.longitude, event.fcmToken);
    case InsertRequest(): _insertRequest(event.reqIdx, event.categoryIdx, event.title, event.content, event.address, event.latitude, event.longitude, event.date, event.runningTime, event.reward, event.waypointsLocation, event.waypointsContent, event.requestType, event.secondType);
    case GetUser(): _getUser(event.id);
    case UpdateLocation(): _updateLocation(event.idx, event.latitude, event.longitude);
    case RequesterRegistration(): _requesterRegistration(event.idx);
    case WorkerRegistration(): _workerRegistration(event.idx);
    case UpdateUserPhoto(): _updateUserPhoto(event.idx, event.filename);
    case UpdateUserName(): _updateUserName(event.idx, event.name);
    case UpdateUserBio(): _updateUserBio(event.idx, event.bio);
    case UpdateUserIntroduce(): _updateUserIntroduce(event.idx, event.introduce);
    case UpdateUserTransportation(): _updateUserTransportation(event.idx, event.transportation);
    case UpdateUserWorkCategory(): _updateUserWorkCategory(event.idx, event.workCategory);
    case WorkerRegistration1(): _workerRegistration1(event.idx, event.idCardPath, event.faceCheckPath, event.infs);
    case GetOtherUser(): _getOtherUser(event.tappedWorkerIdx);
    case SendRequestToWorker(): _sendRequestToWorker(event.reqIdx, event.workerIdx, event.categoryIdx, event.title, event.content, event.address, event.latitude, event.longitude, event.date, event.runningTime, event.reword, event.waypointsLocation, event.waypointsContent, event.fcmToken, event.requestType, event.secondType);
    case UpdateWorkableState():  _updateWorkableState(event.idx);
    case UpdateNotWorkableState(): _updateNotWorkableState(event.idx);
    case GetAnnouncement(): _getAnnouncement();
    case GetAnnouncementByIdx(): _getAnnouncementByIdx(event.idx);
    }
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

  Future _getAnnouncement() async{
    final result = _userRepository.getAnnouncement();
    _announcementState = announcementState.copyWith(announcements: await result);
    notifyListeners();
  }

  Future _getAnnouncementByIdx(int idx) async{
    _announcementState = announcementState.copyWith(isLoading: true);
    notifyListeners();

    final result = _userRepository.getAnnouncementByIdx(idx);
    _announcementState = announcementState.copyWith(announcement: await result, isLoading: false);
    notifyListeners();
  }
}
