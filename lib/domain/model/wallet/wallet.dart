import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';

part 'wallet.g.dart';

@freezed
class Wallet with _$Wallet {
  factory Wallet({
    required int idx,
    required int userIdx,
    required int income,
    required int deposit,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}