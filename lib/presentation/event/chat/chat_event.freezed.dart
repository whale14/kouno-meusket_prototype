// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatEvent<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getChatRooms,
    required TResult Function(String roomIdx) getChatContents,
    required TResult Function(ChatContent chatContent) updateChatRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getChatRooms,
    TResult? Function(String roomIdx)? getChatContents,
    TResult? Function(ChatContent chatContent)? updateChatRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getChatRooms,
    TResult Function(String roomIdx)? getChatContents,
    TResult Function(ChatContent chatContent)? updateChatRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetChatRooms<T> value) getChatRooms,
    required TResult Function(GetChatContents<T> value) getChatContents,
    required TResult Function(UpdateChatRead<T> value) updateChatRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetChatRooms<T> value)? getChatRooms,
    TResult? Function(GetChatContents<T> value)? getChatContents,
    TResult? Function(UpdateChatRead<T> value)? updateChatRead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetChatRooms<T> value)? getChatRooms,
    TResult Function(GetChatContents<T> value)? getChatContents,
    TResult Function(UpdateChatRead<T> value)? updateChatRead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<T, $Res> {
  factory $ChatEventCopyWith(
          ChatEvent<T> value, $Res Function(ChatEvent<T>) then) =
      _$ChatEventCopyWithImpl<T, $Res, ChatEvent<T>>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<T, $Res, $Val extends ChatEvent<T>>
    implements $ChatEventCopyWith<T, $Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetChatRoomsCopyWith<T, $Res> {
  factory _$$GetChatRoomsCopyWith(
          _$GetChatRooms<T> value, $Res Function(_$GetChatRooms<T>) then) =
      __$$GetChatRoomsCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String idx});
}

/// @nodoc
class __$$GetChatRoomsCopyWithImpl<T, $Res>
    extends _$ChatEventCopyWithImpl<T, $Res, _$GetChatRooms<T>>
    implements _$$GetChatRoomsCopyWith<T, $Res> {
  __$$GetChatRoomsCopyWithImpl(
      _$GetChatRooms<T> _value, $Res Function(_$GetChatRooms<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
  }) {
    return _then(_$GetChatRooms<T>(
      null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetChatRooms<T> implements GetChatRooms<T> {
  const _$GetChatRooms(this.idx);

  @override
  final String idx;

  @override
  String toString() {
    return 'ChatEvent<$T>.getChatRooms(idx: $idx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetChatRooms<T> &&
            (identical(other.idx, idx) || other.idx == idx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetChatRoomsCopyWith<T, _$GetChatRooms<T>> get copyWith =>
      __$$GetChatRoomsCopyWithImpl<T, _$GetChatRooms<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getChatRooms,
    required TResult Function(String roomIdx) getChatContents,
    required TResult Function(ChatContent chatContent) updateChatRead,
  }) {
    return getChatRooms(idx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getChatRooms,
    TResult? Function(String roomIdx)? getChatContents,
    TResult? Function(ChatContent chatContent)? updateChatRead,
  }) {
    return getChatRooms?.call(idx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getChatRooms,
    TResult Function(String roomIdx)? getChatContents,
    TResult Function(ChatContent chatContent)? updateChatRead,
    required TResult orElse(),
  }) {
    if (getChatRooms != null) {
      return getChatRooms(idx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetChatRooms<T> value) getChatRooms,
    required TResult Function(GetChatContents<T> value) getChatContents,
    required TResult Function(UpdateChatRead<T> value) updateChatRead,
  }) {
    return getChatRooms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetChatRooms<T> value)? getChatRooms,
    TResult? Function(GetChatContents<T> value)? getChatContents,
    TResult? Function(UpdateChatRead<T> value)? updateChatRead,
  }) {
    return getChatRooms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetChatRooms<T> value)? getChatRooms,
    TResult Function(GetChatContents<T> value)? getChatContents,
    TResult Function(UpdateChatRead<T> value)? updateChatRead,
    required TResult orElse(),
  }) {
    if (getChatRooms != null) {
      return getChatRooms(this);
    }
    return orElse();
  }
}

abstract class GetChatRooms<T> implements ChatEvent<T> {
  const factory GetChatRooms(final String idx) = _$GetChatRooms<T>;

  String get idx;
  @JsonKey(ignore: true)
  _$$GetChatRoomsCopyWith<T, _$GetChatRooms<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetChatContentsCopyWith<T, $Res> {
  factory _$$GetChatContentsCopyWith(_$GetChatContents<T> value,
          $Res Function(_$GetChatContents<T>) then) =
      __$$GetChatContentsCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String roomIdx});
}

/// @nodoc
class __$$GetChatContentsCopyWithImpl<T, $Res>
    extends _$ChatEventCopyWithImpl<T, $Res, _$GetChatContents<T>>
    implements _$$GetChatContentsCopyWith<T, $Res> {
  __$$GetChatContentsCopyWithImpl(
      _$GetChatContents<T> _value, $Res Function(_$GetChatContents<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomIdx = null,
  }) {
    return _then(_$GetChatContents<T>(
      null == roomIdx
          ? _value.roomIdx
          : roomIdx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetChatContents<T> implements GetChatContents<T> {
  const _$GetChatContents(this.roomIdx);

  @override
  final String roomIdx;

  @override
  String toString() {
    return 'ChatEvent<$T>.getChatContents(roomIdx: $roomIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetChatContents<T> &&
            (identical(other.roomIdx, roomIdx) || other.roomIdx == roomIdx));
  }

  @override
  int get hashCode => Object.hash(runtimeType, roomIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetChatContentsCopyWith<T, _$GetChatContents<T>> get copyWith =>
      __$$GetChatContentsCopyWithImpl<T, _$GetChatContents<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getChatRooms,
    required TResult Function(String roomIdx) getChatContents,
    required TResult Function(ChatContent chatContent) updateChatRead,
  }) {
    return getChatContents(roomIdx);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getChatRooms,
    TResult? Function(String roomIdx)? getChatContents,
    TResult? Function(ChatContent chatContent)? updateChatRead,
  }) {
    return getChatContents?.call(roomIdx);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getChatRooms,
    TResult Function(String roomIdx)? getChatContents,
    TResult Function(ChatContent chatContent)? updateChatRead,
    required TResult orElse(),
  }) {
    if (getChatContents != null) {
      return getChatContents(roomIdx);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetChatRooms<T> value) getChatRooms,
    required TResult Function(GetChatContents<T> value) getChatContents,
    required TResult Function(UpdateChatRead<T> value) updateChatRead,
  }) {
    return getChatContents(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetChatRooms<T> value)? getChatRooms,
    TResult? Function(GetChatContents<T> value)? getChatContents,
    TResult? Function(UpdateChatRead<T> value)? updateChatRead,
  }) {
    return getChatContents?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetChatRooms<T> value)? getChatRooms,
    TResult Function(GetChatContents<T> value)? getChatContents,
    TResult Function(UpdateChatRead<T> value)? updateChatRead,
    required TResult orElse(),
  }) {
    if (getChatContents != null) {
      return getChatContents(this);
    }
    return orElse();
  }
}

abstract class GetChatContents<T> implements ChatEvent<T> {
  const factory GetChatContents(final String roomIdx) = _$GetChatContents<T>;

  String get roomIdx;
  @JsonKey(ignore: true)
  _$$GetChatContentsCopyWith<T, _$GetChatContents<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateChatReadCopyWith<T, $Res> {
  factory _$$UpdateChatReadCopyWith(
          _$UpdateChatRead<T> value, $Res Function(_$UpdateChatRead<T>) then) =
      __$$UpdateChatReadCopyWithImpl<T, $Res>;
  @useResult
  $Res call({ChatContent chatContent});

  $ChatContentCopyWith<$Res> get chatContent;
}

/// @nodoc
class __$$UpdateChatReadCopyWithImpl<T, $Res>
    extends _$ChatEventCopyWithImpl<T, $Res, _$UpdateChatRead<T>>
    implements _$$UpdateChatReadCopyWith<T, $Res> {
  __$$UpdateChatReadCopyWithImpl(
      _$UpdateChatRead<T> _value, $Res Function(_$UpdateChatRead<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatContent = null,
  }) {
    return _then(_$UpdateChatRead<T>(
      null == chatContent
          ? _value.chatContent
          : chatContent // ignore: cast_nullable_to_non_nullable
              as ChatContent,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatContentCopyWith<$Res> get chatContent {
    return $ChatContentCopyWith<$Res>(_value.chatContent, (value) {
      return _then(_value.copyWith(chatContent: value));
    });
  }
}

/// @nodoc

class _$UpdateChatRead<T> implements UpdateChatRead<T> {
  const _$UpdateChatRead(this.chatContent);

  @override
  final ChatContent chatContent;

  @override
  String toString() {
    return 'ChatEvent<$T>.updateChatRead(chatContent: $chatContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateChatRead<T> &&
            (identical(other.chatContent, chatContent) ||
                other.chatContent == chatContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateChatReadCopyWith<T, _$UpdateChatRead<T>> get copyWith =>
      __$$UpdateChatReadCopyWithImpl<T, _$UpdateChatRead<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String idx) getChatRooms,
    required TResult Function(String roomIdx) getChatContents,
    required TResult Function(ChatContent chatContent) updateChatRead,
  }) {
    return updateChatRead(chatContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String idx)? getChatRooms,
    TResult? Function(String roomIdx)? getChatContents,
    TResult? Function(ChatContent chatContent)? updateChatRead,
  }) {
    return updateChatRead?.call(chatContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String idx)? getChatRooms,
    TResult Function(String roomIdx)? getChatContents,
    TResult Function(ChatContent chatContent)? updateChatRead,
    required TResult orElse(),
  }) {
    if (updateChatRead != null) {
      return updateChatRead(chatContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetChatRooms<T> value) getChatRooms,
    required TResult Function(GetChatContents<T> value) getChatContents,
    required TResult Function(UpdateChatRead<T> value) updateChatRead,
  }) {
    return updateChatRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetChatRooms<T> value)? getChatRooms,
    TResult? Function(GetChatContents<T> value)? getChatContents,
    TResult? Function(UpdateChatRead<T> value)? updateChatRead,
  }) {
    return updateChatRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetChatRooms<T> value)? getChatRooms,
    TResult Function(GetChatContents<T> value)? getChatContents,
    TResult Function(UpdateChatRead<T> value)? updateChatRead,
    required TResult orElse(),
  }) {
    if (updateChatRead != null) {
      return updateChatRead(this);
    }
    return orElse();
  }
}

abstract class UpdateChatRead<T> implements ChatEvent<T> {
  const factory UpdateChatRead(final ChatContent chatContent) =
      _$UpdateChatRead<T>;

  ChatContent get chatContent;
  @JsonKey(ignore: true)
  _$$UpdateChatReadCopyWith<T, _$UpdateChatRead<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
