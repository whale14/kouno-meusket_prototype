// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_recruitment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestRecruitment _$$_RequestRecruitmentFromJson(
        Map<String, dynamic> json) =>
    _$_RequestRecruitment(
      idx: json['idx'] as int,
      requestIdx: json['requestIdx'] as int,
      userIdx: json['userIdx'] as int,
      isRejected: json['isRejected'] as int,
      workerName: json['workerName'] as String,
      workerImgUrl: json['workerImgUrl'] as String,
      transportation: json['transportation'] as String,
      workCategory: json['workCategory'] as String,
    );

Map<String, dynamic> _$$_RequestRecruitmentToJson(
        _$_RequestRecruitment instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'requestIdx': instance.requestIdx,
      'userIdx': instance.userIdx,
      'isRejected': instance.isRejected,
      'workerName': instance.workerName,
      'workerImgUrl': instance.workerImgUrl,
      'transportation': instance.transportation,
      'workCategory': instance.workCategory,
    };
