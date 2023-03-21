// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TestEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getTests,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getTests,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getTests,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(getTests value) getTests,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(getTests value)? getTests,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(getTests value)? getTests,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestEventCopyWith<$Res> {
  factory $TestEventCopyWith(TestEvent value, $Res Function(TestEvent) then) =
      _$TestEventCopyWithImpl<$Res, TestEvent>;
}

/// @nodoc
class _$TestEventCopyWithImpl<$Res, $Val extends TestEvent>
    implements $TestEventCopyWith<$Res> {
  _$TestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$getTestsCopyWith<$Res> {
  factory _$$getTestsCopyWith(
          _$getTests value, $Res Function(_$getTests) then) =
      __$$getTestsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$getTestsCopyWithImpl<$Res>
    extends _$TestEventCopyWithImpl<$Res, _$getTests>
    implements _$$getTestsCopyWith<$Res> {
  __$$getTestsCopyWithImpl(_$getTests _value, $Res Function(_$getTests) _then)
      : super(_value, _then);
}

/// @nodoc

class _$getTests implements getTests {
  const _$getTests();

  @override
  String toString() {
    return 'TestEvent.getTests()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$getTests);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getTests,
  }) {
    return getTests();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? getTests,
  }) {
    return getTests?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getTests,
    required TResult orElse(),
  }) {
    if (getTests != null) {
      return getTests();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(getTests value) getTests,
  }) {
    return getTests(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(getTests value)? getTests,
  }) {
    return getTests?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(getTests value)? getTests,
    required TResult orElse(),
  }) {
    if (getTests != null) {
      return getTests(this);
    }
    return orElse();
  }
}

abstract class getTests implements TestEvent {
  const factory getTests() = _$getTests;
}
