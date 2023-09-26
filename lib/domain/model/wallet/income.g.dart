// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Income _$$_IncomeFromJson(Map<String, dynamic> json) => _$_Income(
      idx: json['idx'] as int,
      userIdx: json['userIdx'] as int,
      requestIdx: json['requestIdx'] as int,
      income: json['income'] as int,
      incomeAt: json['incomeAt'] as String,
    );

Map<String, dynamic> _$$_IncomeToJson(_$_Income instance) => <String, dynamic>{
      'idx': instance.idx,
      'userIdx': instance.userIdx,
      'requestIdx': instance.requestIdx,
      'income': instance.income,
      'incomeAt': instance.incomeAt,
    };
