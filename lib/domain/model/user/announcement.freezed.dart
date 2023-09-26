// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) {
  return _Announcement.fromJson(json);
}

/// @nodoc
mixin _$Announcement {
  int get idx => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get announceAt => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnnouncementCopyWith<Announcement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementCopyWith<$Res> {
  factory $AnnouncementCopyWith(
          Announcement value, $Res Function(Announcement) then) =
      _$AnnouncementCopyWithImpl<$Res, Announcement>;
  @useResult
  $Res call(
      {int idx,
      String type,
      String author,
      String announceAt,
      String content,
      String title});
}

/// @nodoc
class _$AnnouncementCopyWithImpl<$Res, $Val extends Announcement>
    implements $AnnouncementCopyWith<$Res> {
  _$AnnouncementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? type = null,
    Object? author = null,
    Object? announceAt = null,
    Object? content = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      announceAt: null == announceAt
          ? _value.announceAt
          : announceAt // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnnouncementCopyWith<$Res>
    implements $AnnouncementCopyWith<$Res> {
  factory _$$_AnnouncementCopyWith(
          _$_Announcement value, $Res Function(_$_Announcement) then) =
      __$$_AnnouncementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      String type,
      String author,
      String announceAt,
      String content,
      String title});
}

/// @nodoc
class __$$_AnnouncementCopyWithImpl<$Res>
    extends _$AnnouncementCopyWithImpl<$Res, _$_Announcement>
    implements _$$_AnnouncementCopyWith<$Res> {
  __$$_AnnouncementCopyWithImpl(
      _$_Announcement _value, $Res Function(_$_Announcement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? type = null,
    Object? author = null,
    Object? announceAt = null,
    Object? content = null,
    Object? title = null,
  }) {
    return _then(_$_Announcement(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      announceAt: null == announceAt
          ? _value.announceAt
          : announceAt // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Announcement implements _Announcement {
  _$_Announcement(
      {required this.idx,
      required this.type,
      required this.author,
      required this.announceAt,
      required this.content,
      required this.title});

  factory _$_Announcement.fromJson(Map<String, dynamic> json) =>
      _$$_AnnouncementFromJson(json);

  @override
  final int idx;
  @override
  final String type;
  @override
  final String author;
  @override
  final String announceAt;
  @override
  final String content;
  @override
  final String title;

  @override
  String toString() {
    return 'Announcement(idx: $idx, type: $type, author: $author, announceAt: $announceAt, content: $content, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Announcement &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.announceAt, announceAt) ||
                other.announceAt == announceAt) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, type, author, announceAt, content, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnnouncementCopyWith<_$_Announcement> get copyWith =>
      __$$_AnnouncementCopyWithImpl<_$_Announcement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnnouncementToJson(
      this,
    );
  }
}

abstract class _Announcement implements Announcement {
  factory _Announcement(
      {required final int idx,
      required final String type,
      required final String author,
      required final String announceAt,
      required final String content,
      required final String title}) = _$_Announcement;

  factory _Announcement.fromJson(Map<String, dynamic> json) =
      _$_Announcement.fromJson;

  @override
  int get idx;
  @override
  String get type;
  @override
  String get author;
  @override
  String get announceAt;
  @override
  String get content;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_AnnouncementCopyWith<_$_Announcement> get copyWith =>
      throw _privateConstructorUsedError;
}
