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
    );

Map<String, dynamic> _$$_WalletStateToJson(_$_WalletState instance) =>
    <String, dynamic>{
      'wallet': instance.wallet,
    };
