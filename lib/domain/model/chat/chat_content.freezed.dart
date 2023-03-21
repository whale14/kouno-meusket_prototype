// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatContent _$ChatContentFromJson(Map<String, dynamic> json) {
  return _ChatContent.fromJson(json);
}

/// @nodoc
mixin _$ChatContent {
  int get idx => throw _privateConstructorUsedError;
  int get roomIdx => throw _privateConstructorUsedError;
  int get userIdx => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  int get isRead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatContentCopyWith<ChatContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatContentCopyWith<$Res> {
  factory $ChatContentCopyWith(
          ChatContent value, $Res Function(ChatContent) then) =
      _$ChatContentCopyWithImpl<$Res, ChatContent>;
  @useResult
  $Res call(
      {int idx,
      int roomIdx,
      int userIdx,
      String content,
      String time,
      int isRead});
}

/// @nodoc
class _$ChatContentCopyWithImpl<$Res, $Val extends ChatContent>
    implements $ChatContentCopyWith<$Res> {
  _$ChatContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? roomIdx = null,
    Object? userIdx = null,
    Object? content = null,
    Object? time = null,
    Object? isRead = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      roomIdx: null == roomIdx
          ? _value.roomIdx
          : roomIdx // ignore: cast_nullable_to_non_nullable
              as int,
      userIdx: null == userIdx
          ? _value.userIdx
          : userIdx // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatContentCopyWith<$Res>
    implements $ChatContentCopyWith<$Res> {
  factory _$$_ChatContentCopyWith(
          _$_ChatContent value, $Res Function(_$_ChatContent) then) =
      __$$_ChatContentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      int roomIdx,
      int userIdx,
      String content,
      String time,
      int isRead});
}

/// @nodoc
class __$$_ChatContentCopyWithImpl<$Res>
    extends _$ChatContentCopyWithImpl<$Res, _$_ChatContent>
    implements _$$_ChatContentCopyWith<$Res> {
  __$$_ChatContentCopyWithImpl(
      _$_ChatContent _value, $Res Function(_$_ChatContent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? roomIdx = null,
    Object? userIdx = null,
    Object? content = null,
    Object? time = null,
    Object? isRead = null,
  }) {
    return _then(_$_ChatContent(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      roomIdx: null == roomIdx
          ? _value.roomIdx
          : roomIdx // ignore: cast_nullable_to_non_nullable
              as int,
      userIdx: null == userIdx
          ? _value.userIdx
          : userIdx // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatContent implements _ChatContent {
  _$_ChatContent(
      {required this.idx,
      required this.roomIdx,
      required this.userIdx,
      required this.content,
      required this.time,
      required this.isRead});

  factory _$_ChatContent.fromJson(Map<String, dynamic> json) =>
      _$$_ChatContentFromJson(json);

  @override
  final int idx;
  @override
  final int roomIdx;
  @override
  final int userIdx;
  @override
  final String content;
  @override
  final String time;
  @override
  final int isRead;

  @override
  String toString() {
    return 'ChatContent(idx: $idx, roomIdx: $roomIdx, userIdx: $userIdx, content: $content, time: $time, isRead: $isRead)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatContent &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.roomIdx, roomIdx) || other.roomIdx == roomIdx) &&
            (identical(other.userIdx, userIdx) || other.userIdx == userIdx) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, roomIdx, userIdx, content, time, isRead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatContentCopyWith<_$_ChatContent> get copyWith =>
      __$$_ChatContentCopyWithImpl<_$_ChatContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatContentToJson(
      this,
    );
  }
}

abstract class _ChatContent implements ChatContent {
  factory _ChatContent(
      {required final int idx,
      required final int roomIdx,
      required final int userIdx,
      required final String content,
      required final String time,
      required final int isRead}) = _$_ChatContent;

  factory _ChatContent.fromJson(Map<String, dynamic> json) =
      _$_ChatContent.fromJson;

  @override
  int get idx;
  @override
  int get roomIdx;
  @override
  int get userIdx;
  @override
  String get content;
  @override
  String get time;
  @override
  int get isRead;
  @override
  @JsonKey(ignore: true)
  _$$_ChatContentCopyWith<_$_ChatContent> get copyWith =>
      throw _privateConstructorUsedError;
}
