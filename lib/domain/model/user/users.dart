import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';

part 'users.g.dart';

@freezed
class Users with _$Users {
  factory Users({
    required int idx,
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    required String createAt,
    required String updateAt,
    required int doingState,
    required int accountState,
    required int isRequesterRegist,
    required int isWorkerRegist
  }) = _Users;

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
}