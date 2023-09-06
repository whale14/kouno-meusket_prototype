// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WaypointState _$$_WaypointStateFromJson(Map<String, dynamic> json) =>
    _$_WaypointState(
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      waypoint: json['waypoint'] == null
          ? null
          : Waypoint.fromJson(json['waypoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WaypointStateToJson(_$_WaypointState instance) =>
    <String, dynamic>{
      'waypoints': instance.waypoints,
      'waypoint': instance.waypoint,
    };
