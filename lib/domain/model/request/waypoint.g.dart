// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Waypoint _$$_WaypointFromJson(Map<String, dynamic> json) => _$_Waypoint(
      idx: json['idx'] as int,
      requestIdx: json['requestIdx'] as int,
      content: json['content'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$$_WaypointToJson(_$_Waypoint instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'requestIdx': instance.requestIdx,
      'content': instance.content,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
