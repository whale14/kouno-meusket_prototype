import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';


@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.getUser(String id) = GetUser;
  const factory UserEvent.updateLocation(String idx, double latitude, double longitude) = UpdateLocation;
}