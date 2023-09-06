import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/user/wallet.dart';

part 'wallet_state.freezed.dart';

part 'wallet_state.g.dart';

@freezed
class WalletState with _$WalletState {
  factory WalletState({
    Wallet? wallet,
  }) = _WalletState;

  factory WalletState.fromJson(Map<String, dynamic> json) => _$WalletStateFromJson(json);
}