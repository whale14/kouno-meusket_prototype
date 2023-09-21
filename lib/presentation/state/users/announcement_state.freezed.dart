// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnnouncementState _$AnnouncementStateFromJson(Map<String, dynamic> json) {
  return _AnnouncementState.fromJson(json);
}

/// @nodoc
mixin _$AnnouncementState {
  Announcement? get announcement => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnnouncementStateCopyWith<AnnouncementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementStateCopyWith<$Res> {
  factory $AnnouncementStateCopyWith(
          AnnouncementState value, $Res Function(AnnouncementState) then) =
      _$AnnouncementStateCopyWithImpl<$Res, AnnouncementState>;
  @useResult
  $Res call({Announcement? announcement});

  $AnnouncementCopyWith<$Res>? get announcement;
}

/// @nodoc
class _$AnnouncementStateCopyWithImpl<$Res, $Val extends AnnouncementState>
    implements $AnnouncementStateCopyWith<$Res> {
  _$AnnouncementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? announcement = freezed,
  }) {
    return _then(_value.copyWith(
      announcement: freezed == announcement
          ? _value.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as Announcement?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AnnouncementCopyWith<$Res>? get announcement {
    if (_value.announcement == null) {
      return null;
    }

    return $AnnouncementCopyWith<$Res>(_value.announcement!, (value) {
      return _then(_value.copyWith(announcement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AnnouncementStateCopyWith<$Res>
    implements $AnnouncementStateCopyWith<$Res> {
  factory _$$_AnnouncementStateCopyWith(_$_AnnouncementState value,
          $Res Function(_$_AnnouncementState) then) =
      __$$_AnnouncementStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Announcement? announcement});

  @override
  $AnnouncementCopyWith<$Res>? get announcement;
}

/// @nodoc
class __$$_AnnouncementStateCopyWithImpl<$Res>
    extends _$AnnouncementStateCopyWithImpl<$Res, _$_AnnouncementState>
    implements _$$_AnnouncementStateCopyWith<$Res> {
  __$$_AnnouncementStateCopyWithImpl(
      _$_AnnouncementState _value, $Res Function(_$_AnnouncementState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? announcement = freezed,
  }) {
    return _then(_$_AnnouncementState(
      announcement: freezed == announcement
          ? _value.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as Announcement?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnnouncementState implements _AnnouncementState {
  _$_AnnouncementState({this.announcement});

  factory _$_AnnouncementState.fromJson(Map<String, dynamic> json) =>
      _$$_AnnouncementStateFromJson(json);

  @override
  final Announcement? announcement;

  @override
  String toString() {
    return 'AnnouncementState(announcement: $announcement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnnouncementState &&
            (identical(other.announcement, announcement) ||
                other.announcement == announcement));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, announcement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnnouncementStateCopyWith<_$_AnnouncementState> get copyWith =>
      __$$_AnnouncementStateCopyWithImpl<_$_AnnouncementState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnnouncementStateToJson(
      this,
    );
  }
}

abstract class _AnnouncementState implements AnnouncementState {
  factory _AnnouncementState({final Announcement? announcement}) =
      _$_AnnouncementState;

  factory _AnnouncementState.fromJson(Map<String, dynamic> json) =
      _$_AnnouncementState.fromJson;

  @override
  Announcement? get announcement;
  @override
  @JsonKey(ignore: true)
  _$$_AnnouncementStateCopyWith<_$_AnnouncementState> get copyWith =>
      throw _privateConstructorUsedError;
}
