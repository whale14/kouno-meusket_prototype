import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/domain/model/user/user.dart';

part 'other_user_state.freezed.dart';

part 'other_user_state.g.dart';

@freezed
class OtherUserState with _$OtherUserState {
  factory OtherUserState({
    User? user,
    @Default(false) bool isLoading,

  }) = _OtherUserState;

  factory OtherUserState.fromJson(Map<String, dynamic> json) => _$OtherUserStateFromJson(json);
}