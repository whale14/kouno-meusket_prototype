// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletState _$$_WalletStateFromJson(Map<String, dynamic> json) =>
    _$_WalletState(
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      deposits: (json['deposits'] as List<dynamic>?)
              ?.map((e) => Deposit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      incomes: (json['incomes'] as List<dynamic>?)
              ?.map((e) => Income.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_WalletStateToJson(_$_WalletState instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
      'deposits': instance.deposits,
      'incomes': instance.incomes,
    };
