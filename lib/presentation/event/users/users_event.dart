import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_event.freezed.dart';


@freezed
class UsersEvent with _$UsersEvent {
  const factory UsersEvent.getAroundHelpers(String id) = GetAroundHelpers;
  const factory UsersEvent.insert(String id, String name, double latitude, double longitude) = Insert;
  const factory UsersEvent.insertRequest(String reqIdx, String categoryIdx, String title, String content, String address, String latitude, String longitude) = InsertRequest;
  const factory UsersEvent.getUser(String id) = GetUser;
  const factory UsersEvent.updateLocation(String idx, double latitude, double longitude) = UpdateLocation;
  const factory UsersEvent.requesterRegistration(String idx) = RequesterRegistration;
  const factory UsersEvent.workerRegistration(String idx) = WorkerRegistration;

}