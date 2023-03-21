import 'package:freezed_annotation/freezed_annotation.dart';

part 'test.freezed.dart';

part 'test.g.dart';

@freezed
class Test with _$Test {
  factory Test({
    required int idx,
    required DateTime createAt,
    required String name
  }) = _Test;

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
}