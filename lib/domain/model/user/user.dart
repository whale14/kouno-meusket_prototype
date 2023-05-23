import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
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
    required int isWorkerRegist,
    required String? bio,
    required String? introduce,
    required String? profileImageUrl,
    required String? transportation,
    required String? workCategory,
    required String fcmToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}