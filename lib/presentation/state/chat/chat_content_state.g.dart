// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_content_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatContentState _$$_ChatContentStateFromJson(Map<String, dynamic> json) =>
    _$_ChatContentState(
      chatContents: (json['chatContents'] as List<dynamic>?)
              ?.map((e) => ChatContent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ChatContentStateToJson(_$_ChatContentState instance) =>
    <String, dynamic>{
      'chatContents': instance.chatContents,
    };
