sealed class UsersEvent<T> {
  factory UsersEvent.getAroundHelpers(
      String id, List<bool> workCategoryCheckValues, List<bool> ageGroupCheckValues, List<bool> genderCheckValues, int distanceIndex) = GetAroundHelpers;

  factory UsersEvent.insert(String id, String name, String bio, double latitude, double longitude, String fcmToken) = Insert;

  factory UsersEvent.insertRequest(
      String reqIdx,
      String categoryIdx,
      String title,
      String content,
      String address,
      String latitude,
      String longitude,
      String date,
      String runningTime,
      String reward,
      List<Map<String, dynamic>> waypointsLocation,
      List<String> waypointsContent,
      int requestType,
      int secondType) = InsertRequest;

  factory UsersEvent.getUser(String id) = GetUser;

  factory UsersEvent.updateLocation(String idx, double latitude, double longitude) = UpdateLocation;

  factory UsersEvent.requesterRegistration(String idx) = RequesterRegistration;

  factory UsersEvent.workerRegistration(String idx) = WorkerRegistration;

  factory UsersEvent.updateUserPhoto(String idx, String fileName) = UpdateUserPhoto;

  factory UsersEvent.updateUserName(String idx, String name) = UpdateUserName;

  factory UsersEvent.updateUserBio(String idx, String bio) = UpdateUserBio;

  factory UsersEvent.updateUserIntroduce(String idx, String introduce) = UpdateUserIntroduce;

  factory UsersEvent.updateUserTransportation(String idx, String transportation) = UpdateUserTransportation;

  factory UsersEvent.updateUserWorkCategory(String idx, String workCategory) = UpdateUserWorkCategory;

  factory UsersEvent.workerRegistration1(String idx, String idCardPath, String faceCheckPath, List<String> infs) = WorkerRegistration1;

  factory UsersEvent.getOtherUser(String tappedWorkerIdx) = GetOtherUser;

  factory UsersEvent.sendRequestToWorker(
      String reqIdx,
      String workerIdx,
      String categoryIdx,
      String title,
      String content,
      String address,
      String latitude,
      String longitude,
      String date,
      String runningTime,
      String reword,
      List<Map<String, dynamic>> waypointsLocation,
      List<String> waypointsContent,
      String fcmToken,
      int requestType,
      int secondType) = SendRequestToWorker;

  factory UsersEvent.updateWorkableState(String idx) = UpdateWorkableState;

  factory UsersEvent.updateNotWorkableState(String idx) = UpdateNotWorkableState;

  factory UsersEvent.myWallet(String idx) = MyWallet;

  factory UsersEvent.getAnnouncement(String type, String search) = GetAnnouncement;
}

class GetAroundHelpers<T> implements UsersEvent<T> {
  final String id;
  final List<bool> workCategoryCheckValues;
  final List<bool> ageGroupCheckValues;
  final List<bool> genderCheckValues;
  final int distanceIndex;

  GetAroundHelpers(this.id, this.workCategoryCheckValues, this.ageGroupCheckValues, this.genderCheckValues, this.distanceIndex);
}

class Insert<T> implements UsersEvent<T> {
  final String id;
  final String name;
  final String bio;
  final double latitude;
  final double longitude;
  final String fcmToken;

  Insert(this.id, this.name, this.bio, this.latitude, this.longitude, this.fcmToken);
}

class InsertRequest<T> implements UsersEvent<T> {
  final String reqIdx;
  final String categoryIdx;
  final String title;
  final String content;
  final String address;
  final String latitude;
  final String longitude;
  final String date;
  final String runningTime;
  final String reward;
  final List<Map<String, dynamic>> waypointsLocation;
  final List<String> waypointsContent;
  final int requestType;
  final int secondType;

  InsertRequest(this.reqIdx, this.categoryIdx, this.title, this.content, this.address, this.latitude, this.longitude, this.date, this.runningTime, this.reward,
      this.waypointsLocation, this.waypointsContent, this.requestType, this.secondType);
}

class GetUser<T> implements UsersEvent<T> {
  final String id;

  GetUser(this.id);
}

class UpdateLocation<T> implements UsersEvent<T> {
  final String idx;
  final double latitude;
  final double longitude;

  UpdateLocation(this.idx, this.latitude, this.longitude);
}

class RequesterRegistration<T> implements UsersEvent<T> {
  final String idx;

  RequesterRegistration(this.idx);
}

class WorkerRegistration<T> implements UsersEvent<T> {
  final String idx;

  WorkerRegistration(this.idx);
}

class UpdateUserPhoto<T> implements UsersEvent<T> {
  final String idx;
  final String filename;

  UpdateUserPhoto(this.idx, this.filename);
}

class UpdateUserName<T> implements UsersEvent<T> {
  final String idx;
  final String name;

  UpdateUserName(this.idx, this.name);
}

class UpdateUserBio<T> implements UsersEvent<T> {
  final String idx;
  final String bio;

  UpdateUserBio(this.idx, this.bio);
}

class UpdateUserIntroduce<T> implements UsersEvent<T> {
  final String idx;
  final String introduce;

  UpdateUserIntroduce(this.idx, this.introduce);
}

class UpdateUserTransportation<T> implements UsersEvent<T> {
  final String idx;
  final String transportation;

  UpdateUserTransportation(this.idx, this.transportation);
}

class UpdateUserWorkCategory<T> implements UsersEvent<T> {
  final String idx;
  final String workCategory;

  UpdateUserWorkCategory(this.idx, this.workCategory);
}

class WorkerRegistration1<T> implements UsersEvent<T> {
  final String idx;
  final String idCardPath;
  final String faceCheckPath;
  final List<String> infs;

  WorkerRegistration1(this.idx, this.idCardPath, this.faceCheckPath, this.infs);
}

class GetOtherUser<T> implements UsersEvent<T> {
  final String tappedWorkerIdx;

  GetOtherUser(this.tappedWorkerIdx);
}

class SendRequestToWorker<T> implements UsersEvent<T> {
  final String reqIdx;
  final String workerIdx;
  final String categoryIdx;
  final String title;
  final String content;
  final String address;
  final String latitude;
  final String longitude;
  final String date;
  final String runningTime;
  final String reword;
  final List<Map<String, dynamic>> waypointsLocation;
  final List<String> waypointsContent;
  final String fcmToken;
  final int requestType;
  final int secondType;

  SendRequestToWorker(this.reqIdx, this.workerIdx, this.categoryIdx, this.title, this.content, this.address, this.latitude, this.longitude, this.date,
      this.runningTime, this.reword, this.waypointsLocation, this.waypointsContent, this.fcmToken, this.requestType, this.secondType);
}

class UpdateWorkableState<T> implements UsersEvent<T> {
  final String idx;

  UpdateWorkableState(this.idx);
}

class UpdateNotWorkableState<T> implements UsersEvent<T> {
  final String idx;

  UpdateNotWorkableState(this.idx);
}

class MyWallet<T> implements UsersEvent<T> {
  final String idx;

  MyWallet(this.idx);
}

class GetAnnouncement<T> implements UsersEvent<T>{
  final String type;
  final String search;

  GetAnnouncement(this.type, this.search);
}
