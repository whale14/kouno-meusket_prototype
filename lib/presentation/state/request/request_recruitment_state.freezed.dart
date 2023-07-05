// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_recruitment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestRecruitmentState _$RequestRecruitmentStateFromJson(
    Map<String, dynamic> json) {
  return _RequestRecruitmentState.fromJson(json);
}

/// @nodoc
mixin _$RequestRecruitmentState {
  List<RequestRecruitment> get recruitments =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestRecruitmentStateCopyWith<RequestRecruitmentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestRecruitmentStateCopyWith<$Res> {
  factory $RequestRecruitmentStateCopyWith(RequestRecruitmentState value,
          $Res Function(RequestRecruitmentState) then) =
      _$RequestRecruitmentStateCopyWithImpl<$Res, RequestRecruitmentState>;
  @useResult
  $Res call({List<RequestRecruitment> recruitments});
}

/// @nodoc
class _$RequestRecruitmentStateCopyWithImpl<$Res,
        $Val extends RequestRecruitmentState>
    implements $RequestRecruitmentStateCopyWith<$Res> {
  _$RequestRecruitmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recruitments = null,
  }) {
    return _then(_value.copyWith(
      recruitments: null == recruitments
          ? _value.recruitments
          : recruitments // ignore: cast_nullable_to_non_nullable
              as List<RequestRecruitment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RequestRecruitmentStateCopyWith<$Res>
    implements $RequestRecruitmentStateCopyWith<$Res> {
  factory _$$_RequestRecruitmentStateCopyWith(_$_RequestRecruitmentState value,
          $Res Function(_$_RequestRecruitmentState) then) =
      __$$_RequestRecruitmentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RequestRecruitment> recruitments});
}

/// @nodoc
class __$$_RequestRecruitmentStateCopyWithImpl<$Res>
    extends _$RequestRecruitmentStateCopyWithImpl<$Res,
        _$_RequestRecruitmentState>
    implements _$$_RequestRecruitmentStateCopyWith<$Res> {
  __$$_RequestRecruitmentStateCopyWithImpl(_$_RequestRecruitmentState _value,
      $Res Function(_$_RequestRecruitmentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recruitments = null,
  }) {
    return _then(_$_RequestRecruitmentState(
      recruitments: null == recruitments
          ? _value._recruitments
          : recruitments // ignore: cast_nullable_to_non_nullable
              as List<RequestRecruitment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestRecruitmentState implements _RequestRecruitmentState {
  _$_RequestRecruitmentState(
      {final List<RequestRecruitment> recruitments = const []})
      : _recruitments = recruitments;

  factory _$_RequestRecruitmentState.fromJson(Map<String, dynamic> json) =>
      _$$_RequestRecruitmentStateFromJson(json);

  final List<RequestRecruitment> _recruitments;
  @override
  @JsonKey()
  List<RequestRecruitment> get recruitments {
    if (_recruitments is EqualUnmodifiableListView) return _recruitments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recruitments);
  }

  @override
  String toString() {
    return 'RequestRecruitmentState(recruitments: $recruitments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestRecruitmentState &&
            const DeepCollectionEquality()
                .equals(other._recruitments, _recruitments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_recruitments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestRecruitmentStateCopyWith<_$_RequestRecruitmentState>
      get copyWith =>
          __$$_RequestRecruitmentStateCopyWithImpl<_$_RequestRecruitmentState>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestRecruitmentStateToJson(
      this,
    );
  }
}

abstract class _RequestRecruitmentState implements RequestRecruitmentState {
  factory _RequestRecruitmentState(
          {final List<RequestRecruitment> recruitments}) =
      _$_RequestRecruitmentState;

  factory _RequestRecruitmentState.fromJson(Map<String, dynamic> json) =
      _$_RequestRecruitmentState.fromJson;

  @override
  List<RequestRecruitment> get recruitments;
  @override
  @JsonKey(ignore: true)
  _$$_RequestRecruitmentStateCopyWith<_$_RequestRecruitmentState>
      get copyWith => throw _privateConstructorUsedError;
}
