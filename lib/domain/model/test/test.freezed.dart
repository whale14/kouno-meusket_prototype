// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Test _$TestFromJson(Map<String, dynamic> json) {
  return _Test.fromJson(json);
}

/// @nodoc
mixin _$Test {
  int get idx => throw _privateConstructorUsedError;
  DateTime get createAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestCopyWith<Test> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestCopyWith<$Res> {
  factory $TestCopyWith(Test value, $Res Function(Test) then) =
      _$TestCopyWithImpl<$Res, Test>;
  @useResult
  $Res call({int idx, DateTime createAt, String name});
}

/// @nodoc
class _$TestCopyWithImpl<$Res, $Val extends Test>
    implements $TestCopyWith<$Res> {
  _$TestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? createAt = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TestCopyWith<$Res> implements $TestCopyWith<$Res> {
  factory _$$_TestCopyWith(_$_Test value, $Res Function(_$_Test) then) =
      __$$_TestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idx, DateTime createAt, String name});
}

/// @nodoc
class __$$_TestCopyWithImpl<$Res> extends _$TestCopyWithImpl<$Res, _$_Test>
    implements _$$_TestCopyWith<$Res> {
  __$$_TestCopyWithImpl(_$_Test _value, $Res Function(_$_Test) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? createAt = null,
    Object? name = null,
  }) {
    return _then(_$_Test(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Test implements _Test {
  _$_Test({required this.idx, required this.createAt, required this.name});

  factory _$_Test.fromJson(Map<String, dynamic> json) => _$$_TestFromJson(json);

  @override
  final int idx;
  @override
  final DateTime createAt;
  @override
  final String name;

  @override
  String toString() {
    return 'Test(idx: $idx, createAt: $createAt, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Test &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, idx, createAt, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TestCopyWith<_$_Test> get copyWith =>
      __$$_TestCopyWithImpl<_$_Test>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestToJson(
      this,
    );
  }
}

abstract class _Test implements Test {
  factory _Test(
      {required final int idx,
      required final DateTime createAt,
      required final String name}) = _$_Test;

  factory _Test.fromJson(Map<String, dynamic> json) = _$_Test.fromJson;

  @override
  int get idx;
  @override
  DateTime get createAt;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TestCopyWith<_$_Test> get copyWith => throw _privateConstructorUsedError;
}
