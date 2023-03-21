// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Test _$$_TestFromJson(Map<String, dynamic> json) => _$_Test(
      idx: json['idx'] as int,
      createAt: DateTime.parse(json['createAt'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_TestToJson(_$_Test instance) => <String, dynamic>{
      'idx': instance.idx,
      'createAt': instance.createAt.toIso8601String(),
      'name': instance.name,
    };
