import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/chat/chat_content.dart';

part 'chat_content_state.freezed.dart';

part 'chat_content_state.g.dart';

@freezed
class ChatContentState with _$ChatContentState {
  factory ChatContentState({
    @Default([]) List<ChatContent> chatContents,
  }) = _ChatContentState;

  factory ChatContentState.fromJson(Map<String, dynamic> json) => _$ChatContentStateFromJson(json);
}