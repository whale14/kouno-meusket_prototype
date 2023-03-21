import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/test/test.dart';

part 'test_state.freezed.dart';

part 'test_state.g.dart';

@freezed
class TestState with _$TestState {
  factory TestState({
    @Default([]) List<Test> tests,
    @Default(false) bool isLoading,
  }) = _TestState;

  factory TestState.fromJson(Map<String, dynamic> json) => _$TestStateFromJson(json);
}