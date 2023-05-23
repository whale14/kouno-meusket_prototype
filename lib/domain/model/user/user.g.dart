// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      idx: json['idx'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createAt: json['createAt'] as String,
      updateAt: json['updateAt'] as String,
      doingState: json['doingState'] as int,
      accountState: json['accountState'] as int,
      isRequesterRegist: json['isRequesterRegist'] as int,
      isWorkerRegist: json['isWorkerRegist'] as int,
      bio: json['bio'] as String?,
      introduce: json['introduce'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      transportation: json['transportation'] as String?,
      workCategory: json['workCategory'] as String?,
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'idx': instance.idx,
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'doingState': instance.doingState,
      'accountState': instance.accountState,
      'isRequesterRegist': instance.isRequesterRegist,
      'isWorkerRegist': instance.isWorkerRegist,
      'bio': instance.bio,
      'introduce': instance.introduce,
      'profileImageUrl': instance.profileImageUrl,
      'transportation': instance.transportation,
      'workCategory': instance.workCategory,
      'fcmToken': instance.fcmToken,
    };
