// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Users _$$_UsersFromJson(Map<String, dynamic> json) => _$_Users(
      idx: json['idx'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createAt: json['createAt'] as String,
      updateAt: json['updateAt'] as String,
      doingState: json['doingState'] as int,
      accountState: json['accountState'] as int,
    );

Map<String, dynamic> _$$_UsersToJson(_$_Users instance) => <String, dynamic>{
      'idx': instance.idx,
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'doingState': instance.doingState,
      'accountState': instance.accountState,
    };
