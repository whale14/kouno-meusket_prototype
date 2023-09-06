import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/request/waypoint.dart';

part 'waypoint_state.freezed.dart';

part 'waypoint_state.g.dart';

@freezed
class WaypointState with _$WaypointState {
  factory WaypointState({
    @Default([]) List<Waypoint> waypoints,
    Waypoint? waypoint,
  }) = _WaypointState;

  factory WaypointState.fromJson(Map<String, dynamic> json) => _$WaypointStateFromJson(json);
}