import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/model/user/user.dart';

part 'users_state.freezed.dart';

part 'users_state.g.dart';

@freezed
class UsersState with _$UsersState {
  factory UsersState({
    @Default([]) List<User> users,
    @Default(false) bool isLoading,
  }) = _UsersState;

  factory UsersState.fromJson(Map<String, dynamic> json) => _$UsersStateFromJson(json);
}