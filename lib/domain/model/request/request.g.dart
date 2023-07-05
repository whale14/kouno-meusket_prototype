// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Request _$$_RequestFromJson(Map<String, dynamic> json) => _$_Request(
      idx: json['idx'] as int,
      requesterIdx: json['requesterIdx'] as int,
      workerIdx: json['workerIdx'] as int,
      workCategoryIdx: json['workCategoryIdx'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      workDate: json['workDate'] == null
          ? null
          : DateTime.parse(json['workDate'] as String),
      runningTime: json['runningTime'] as String?,
      status: json['status'] as int,
      regDate: json['regDate'] as String,
      reward: json['reward'] as int,
      requesterName: json['requesterName'] as String,
      workerName: json['workerName'] as String,
      requesterImgUrl: json['requesterImgUrl'] as String?,
      workerImgUrl: json['workerImgUrl'] as String?,
      recruitmentStatus: json['recruitmentStatus'] as int,
      reviewRequesterIdx: json['reviewRequesterIdx'] as int?,
      reviewWorkerIdx: json['reviewWorkerIdx'] as int?,
    );

Map<String, dynamic> _$$_RequestToJson(_$_Request instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'requesterIdx': instance.requesterIdx,
      'workerIdx': instance.workerIdx,
      'workCategoryIdx': instance.workCategoryIdx,
      'title': instance.title,
      'content': instance.content,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'workDate': instance.workDate?.toIso8601String(),
      'runningTime': instance.runningTime,
      'status': instance.status,
      'regDate': instance.regDate,
      'reward': instance.reward,
      'requesterName': instance.requesterName,
      'workerName': instance.workerName,
      'requesterImgUrl': instance.requesterImgUrl,
      'workerImgUrl': instance.workerImgUrl,
      'recruitmentStatus': instance.recruitmentStatus,
      'reviewRequesterIdx': instance.reviewRequesterIdx,
      'reviewWorkerIdx': instance.reviewWorkerIdx,
    };
