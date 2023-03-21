import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_content.freezed.dart';

part 'chat_content.g.dart';

@freezed
class ChatContent with _$ChatContent {
  factory ChatContent({
    required int idx,
    required int roomIdx,
    required int userIdx,
    required String content,
    required String time,
    required int isRead
  }) = _ChatContent;

  factory ChatContent.fromJson(Map<String, dynamic> json) => _$ChatContentFromJson(json);
}