import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/user/users.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
abstract class UserState<T> with _$UserState<T> {
  factory UserState({
    Users? user,
    @Default(false) bool isLoading,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);
}