import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income.freezed.dart';

part 'income.g.dart';

@freezed
class Income with _$Income {
  factory Income({
    required int idx,
    required int requestIdx,
    required int income,
    required String incomeAt,
  }) = _Income;

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);
}
