import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/users/users.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
abstract class UserState<T> with _$UserState<T> {
  factory UserState({
    @Default([]) List<Users> user,
    @Default(false) bool isLoading,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);
}