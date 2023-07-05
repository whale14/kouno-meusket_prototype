// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_recruitment_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestRecruitmentState _$$_RequestRecruitmentStateFromJson(
        Map<String, dynamic> json) =>
    _$_RequestRecruitmentState(
      recruitments: (json['recruitments'] as List<dynamic>?)
              ?.map(
                  (e) => RequestRecruitment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RequestRecruitmentStateToJson(
        _$_RequestRecruitmentState instance) =>
    <String, dynamic>{
      'recruitments': instance.recruitments,
    };
