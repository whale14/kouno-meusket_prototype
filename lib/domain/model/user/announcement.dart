import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

part 'announcement.g.dart';

@freezed
class Announcement with _$Announcement {
  factory Announcement({
    required int idx,
    required String type,
    required String author,
    required String announcement,
    required String content,
  }) = _Announcement;

factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
}