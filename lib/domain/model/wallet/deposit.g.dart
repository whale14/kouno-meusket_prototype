// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deposit _$$_DepositFromJson(Map<String, dynamic> json) => _$_Deposit(
      idx: json['idx'] as int,
      userIdx: json['userIdx'] as int,
      paymentType: json['paymentType'] as int,
      deposit: json['deposit'] as int,
      depositAt: json['depositAt'] as String,
    );

Map<String, dynamic> _$$_DepositToJson(_$_Deposit instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'userIdx': instance.userIdx,
      'paymentType': instance.paymentType,
      'deposit': instance.deposit,
      'depositAt': instance.depositAt,
    };
