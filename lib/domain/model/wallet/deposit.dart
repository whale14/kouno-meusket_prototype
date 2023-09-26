import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit.freezed.dart';

part 'deposit.g.dart';

@freezed
class Deposit with _$Deposit {
factory Deposit({
  required int idx,
  required int userIdx,
  required int paymentType,
  required int deposit,
  required String depositAt
}) = _Deposit;

factory Deposit.fromJson(Map<String, dynamic> json) => _$DepositFromJson(json);
}