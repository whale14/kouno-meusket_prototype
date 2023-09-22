import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/user/announcement.dart';

part 'announcement_state.freezed.dart';

part 'announcement_state.g.dart';

@freezed
class AnnouncementState with _$AnnouncementState {
factory AnnouncementState({
  Announcement? announcement,
  @Default([]) List<List<Announcement>> announcements,
}) = _AnnouncementState;

factory AnnouncementState.fromJson(Map<String, dynamic> json) => _$AnnouncementStateFromJson(json);
}