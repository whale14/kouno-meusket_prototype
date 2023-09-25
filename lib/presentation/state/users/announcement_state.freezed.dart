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
  bool get isLoading => throw _privateConstructorUsedError;
  Announcement? get announcement => throw _privateConstructorUsedError;
  List<List<Announcement>> get announcements =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {bool isLoading,
      Announcement? announcement,
      List<List<Announcement>> announcements});

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
    Object? isLoading = null,
    Object? announcement = freezed,
    Object? announcements = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      announcement: freezed == announcement
          ? _value.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as Announcement?,
      announcements: null == announcements
          ? _value.announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as List<List<Announcement>>,
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
  $Res call(
      {bool isLoading,
      Announcement? announcement,
      List<List<Announcement>> announcements});

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
    Object? isLoading = null,
    Object? announcement = freezed,
    Object? announcements = null,
  }) {
    return _then(_$_AnnouncementState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      announcement: freezed == announcement
          ? _value.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as Announcement?,
      announcements: null == announcements
          ? _value._announcements
          : announcements // ignore: cast_nullable_to_non_nullable
              as List<List<Announcement>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnnouncementState implements _AnnouncementState {
  _$_AnnouncementState(
      {this.isLoading = false,
      this.announcement,
      final List<List<Announcement>> announcements = const []})
      : _announcements = announcements;

  factory _$_AnnouncementState.fromJson(Map<String, dynamic> json) =>
      _$$_AnnouncementStateFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Announcement? announcement;
  final List<List<Announcement>> _announcements;
  @override
  @JsonKey()
  List<List<Announcement>> get announcements {
    if (_announcements is EqualUnmodifiableListView) return _announcements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_announcements);
  }

  @override
  String toString() {
    return 'AnnouncementState(isLoading: $isLoading, announcement: $announcement, announcements: $announcements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnnouncementState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.announcement, announcement) ||
                other.announcement == announcement) &&
            const DeepCollectionEquality()
                .equals(other._announcements, _announcements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLoading, announcement,
      const DeepCollectionEquality().hash(_announcements));

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
  factory _AnnouncementState(
      {final bool isLoading,
      final Announcement? announcement,
      final List<List<Announcement>> announcements}) = _$_AnnouncementState;

  factory _AnnouncementState.fromJson(Map<String, dynamic> json) =
      _$_AnnouncementState.fromJson;

  @override
  bool get isLoading;
  @override
  Announcement? get announcement;
  @override
  List<List<Announcement>> get announcements;
  @override
  @JsonKey(ignore: true)
  _$$_AnnouncementStateCopyWith<_$_AnnouncementState> get copyWith =>
      throw _privateConstructorUsedError;
}
