import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_event.freezed.dart';


@freezed
class UsersEvent with _$UsersEvent {
  const factory UsersEvent.getAroundHelpers(String id, List<bool> workCategoryCheckValues, List<bool> ageGroupCheckValues, List<bool> genderCheckValues, int distanceIndex) = GetAroundHelpers;
  const factory UsersEvent.insert(String id, String name, String bio, double latitude, double longitude, String fcmToken) = Insert;
  const factory UsersEvent.insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String date, String runningTime, String reward, List<Map<String, dynamic>> waypointsLocation, List<String> waypointsContent, int requestType, int secondType) = InsertRequest;
  const factory UsersEvent.getUser(String id) = GetUser;
  const factory UsersEvent.updateLocation(String idx, double latitude, double longitude) = UpdateLocation;
  const factory UsersEvent.requesterRegistration(String idx) = RequesterRegistration;
  const factory UsersEvent.workerRegistration(String idx) = WorkerRegistration;
  const factory UsersEvent.updateUserPhoto(String idx, String fileName) = UpdateUserPhoto;
  const factory UsersEvent.updateUserName(String idx, String name) = UpdateUserName;
  const factory UsersEvent.updateUserBio(String idx, String bio) = UpdateUserBio;
  const factory UsersEvent.updateUserIntroduce(String idx, String introduce) = UpdateUserIntroduce;
  const factory UsersEvent.updateUserTransportation(String idx, String transportation) = UpdateUserTransportation;
  const factory UsersEvent.updateUserWorkCategory(String idx, String workCategory) = UpdateUserWorkCategory;
  const factory UsersEvent.workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs) = WorkerRegistration1;
  const factory UsersEvent.getOtherUser(String tappedWorkerIdx) = GetOtherUser;
  const factory UsersEvent.sendRequestToWorker(String reqIdx,String workerIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude, String date, String runningTime, String reword, List<Map<String, dynamic>> waypointsLocation, List<String> waypointsContent ,String fcmToken, int requestType, int secondType) = SendRequestToWorker;
  const factory UsersEvent.updateWorkableState(String idx) = UpdateWorkableState;
  const factory UsersEvent.updateNotWorkableState(String idx) = UpdateNotWorkableState;
  const factory UsersEvent.myWallet(String idx) = MyWallet;
}