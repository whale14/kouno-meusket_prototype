// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TestState _$TestStateFromJson(Map<String, dynamic> json) {
  return _TestState.fromJson(json);
}

/// @nodoc
mixin _$TestState {
  List<Test> get tests => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestStateCopyWith<TestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestStateCopyWith<$Res> {
  factory $TestStateCopyWith(TestState value, $Res Function(TestState) then) =
      _$TestStateCopyWithImpl<$Res, TestState>;
  @useResult
  $Res call({List<Test> tests, bool isLoading});
}

/// @nodoc
class _$TestStateCopyWithImpl<$Res, $Val extends TestState>
    implements $TestStateCopyWith<$Res> {
  _$TestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      tests: null == tests
          ? _value.tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<Test>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TestStateCopyWith<$Res> implements $TestStateCopyWith<$Res> {
  factory _$$_TestStateCopyWith(
          _$_TestState value, $Res Function(_$_TestState) then) =
      __$$_TestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Test> tests, bool isLoading});
}

/// @nodoc
class __$$_TestStateCopyWithImpl<$Res>
    extends _$TestStateCopyWithImpl<$Res, _$_TestState>
    implements _$$_TestStateCopyWith<$Res> {
  __$$_TestStateCopyWithImpl(
      _$_TestState _value, $Res Function(_$_TestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
    Object? isLoading = null,
  }) {
    return _then(_$_TestState(
      tests: null == tests
          ? _value._tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<Test>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TestState implements _TestState {
  _$_TestState({final List<Test> tests = const [], this.isLoading = false})
      : _tests = tests;

  factory _$_TestState.fromJson(Map<String, dynamic> json) =>
      _$$_TestStateFromJson(json);

  final List<Test> _tests;
  @override
  @JsonKey()
  List<Test> get tests {
    if (_tests is EqualUnmodifiableListView) return _tests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tests);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'TestState(tests: $tests, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TestState &&
            const DeepCollectionEquality().equals(other._tests, _tests) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_tests), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TestStateCopyWith<_$_TestState> get copyWith =>
      __$$_TestStateCopyWithImpl<_$_TestState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestStateToJson(
      this,
    );
  }
}

abstract class _TestState implements TestState {
  factory _TestState({final List<Test> tests, final bool isLoading}) =
      _$_TestState;

  factory _TestState.fromJson(Map<String, dynamic> json) =
      _$_TestState.fromJson;

  @override
  List<Test> get tests;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_TestStateCopyWith<_$_TestState> get copyWith =>
      throw _privateConstructorUsedError;
}
