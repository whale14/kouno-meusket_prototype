import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'waypoint.freezed.dart';

part 'waypoint.g.dart';

@freezed
class Waypoint with _$Waypoint {
  factory Waypoint({
    required int idx,
    required int requestIdx,
    required String content,
    required double latitude,
    required double longitude,
    required String address,
  }) = _Waypoint;

  factory Waypoint.fromJson(Map<String, dynamic> json) => _$WaypointFromJson(json);
}