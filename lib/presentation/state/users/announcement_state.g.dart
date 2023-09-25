// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnnouncementState _$$_AnnouncementStateFromJson(Map<String, dynamic> json) =>
    _$_AnnouncementState(
      isLoading: json['isLoading'] as bool? ?? false,
      announcement: json['announcement'] == null
          ? null
          : Announcement.fromJson(json['announcement'] as Map<String, dynamic>),
      announcements: (json['announcements'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AnnouncementStateToJson(
        _$_AnnouncementState instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'announcement': instance.announcement,
      'announcements': instance.announcements,
    };
