import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/wallet/wallet.dart';

import '../../../domain/model/wallet/deposit.dart';
import '../../../domain/model/wallet/income.dart';

part 'wallet_state.freezed.dart';

part 'wallet_state.g.dart';

@freezed
class WalletState with _$WalletState {
  factory WalletState({
    @Default(false) bool isLoading,
    Wallet? wallet,
    @Default([]) List<Deposit> deposits,
    @Default([]) List<Income> incomes,
  }) = _WalletState;

  factory WalletState.fromJson(Map<String, dynamic> json) => _$WalletStateFromJson(json);
}