// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatContentState _$ChatContentStateFromJson(Map<String, dynamic> json) {
  return _ChatContentState.fromJson(json);
}

/// @nodoc
mixin _$ChatContentState {
  List<ChatContent> get chatContents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatContentStateCopyWith<ChatContentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatContentStateCopyWith<$Res> {
  factory $ChatContentStateCopyWith(
          ChatContentState value, $Res Function(ChatContentState) then) =
      _$ChatContentStateCopyWithImpl<$Res, ChatContentState>;
  @useResult
  $Res call({List<ChatContent> chatContents});
}

/// @nodoc
class _$ChatContentStateCopyWithImpl<$Res, $Val extends ChatContentState>
    implements $ChatContentStateCopyWith<$Res> {
  _$ChatContentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatContents = null,
  }) {
    return _then(_value.copyWith(
      chatContents: null == chatContents
          ? _value.chatContents
          : chatContents // ignore: cast_nullable_to_non_nullable
              as List<ChatContent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatContentStateCopyWith<$Res>
    implements $ChatContentStateCopyWith<$Res> {
  factory _$$_ChatContentStateCopyWith(
          _$_ChatContentState value, $Res Function(_$_ChatContentState) then) =
      __$$_ChatContentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChatContent> chatContents});
}

/// @nodoc
class __$$_ChatContentStateCopyWithImpl<$Res>
    extends _$ChatContentStateCopyWithImpl<$Res, _$_ChatContentState>
    implements _$$_ChatContentStateCopyWith<$Res> {
  __$$_ChatContentStateCopyWithImpl(
      _$_ChatContentState _value, $Res Function(_$_ChatContentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatContents = null,
  }) {
    return _then(_$_ChatContentState(
      chatContents: null == chatContents
          ? _value._chatContents
          : chatContents // ignore: cast_nullable_to_non_nullable
              as List<ChatContent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatContentState implements _ChatContentState {
  _$_ChatContentState({final List<ChatContent> chatContents = const []})
      : _chatContents = chatContents;

  factory _$_ChatContentState.fromJson(Map<String, dynamic> json) =>
      _$$_ChatContentStateFromJson(json);

  final List<ChatContent> _chatContents;
  @override
  @JsonKey()
  List<ChatContent> get chatContents {
    if (_chatContents is EqualUnmodifiableListView) return _chatContents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatContents);
  }

  @override
  String toString() {
    return 'ChatContentState(chatContents: $chatContents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatContentState &&
            const DeepCollectionEquality()
                .equals(other._chatContents, _chatContents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_chatContents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatContentStateCopyWith<_$_ChatContentState> get copyWith =>
      __$$_ChatContentStateCopyWithImpl<_$_ChatContentState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatContentStateToJson(
      this,
    );
  }
}

abstract class _ChatContentState implements ChatContentState {
  factory _ChatContentState({final List<ChatContent> chatContents}) =
      _$_ChatContentState;

  factory _ChatContentState.fromJson(Map<String, dynamic> json) =
      _$_ChatContentState.fromJson;

  @override
  List<ChatContent> get chatContents;
  @override
  @JsonKey(ignore: true)
  _$$_ChatContentStateCopyWith<_$_ChatContentState> get copyWith =>
      throw _privateConstructorUsedError;
}
