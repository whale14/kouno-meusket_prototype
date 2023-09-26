// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Income _$IncomeFromJson(Map<String, dynamic> json) {
  return _Income.fromJson(json);
}

/// @nodoc
mixin _$Income {
  int get idx => throw _privateConstructorUsedError;
  int get requestIdx => throw _privateConstructorUsedError;
  int get income => throw _privateConstructorUsedError;
  String get incomeAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncomeCopyWith<Income> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeCopyWith<$Res> {
  factory $IncomeCopyWith(Income value, $Res Function(Income) then) =
      _$IncomeCopyWithImpl<$Res, Income>;
  @useResult
  $Res call({int idx, int requestIdx, int income, String incomeAt});
}

/// @nodoc
class _$IncomeCopyWithImpl<$Res, $Val extends Income>
    implements $IncomeCopyWith<$Res> {
  _$IncomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? income = null,
    Object? incomeAt = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as int,
      incomeAt: null == incomeAt
          ? _value.incomeAt
          : incomeAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IncomeCopyWith<$Res> implements $IncomeCopyWith<$Res> {
  factory _$$_IncomeCopyWith(_$_Income value, $Res Function(_$_Income) then) =
      __$$_IncomeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int idx, int requestIdx, int income, String incomeAt});
}

/// @nodoc
class __$$_IncomeCopyWithImpl<$Res>
    extends _$IncomeCopyWithImpl<$Res, _$_Income>
    implements _$$_IncomeCopyWith<$Res> {
  __$$_IncomeCopyWithImpl(_$_Income _value, $Res Function(_$_Income) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? requestIdx = null,
    Object? income = null,
    Object? incomeAt = null,
  }) {
    return _then(_$_Income(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      requestIdx: null == requestIdx
          ? _value.requestIdx
          : requestIdx // ignore: cast_nullable_to_non_nullable
              as int,
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as int,
      incomeAt: null == incomeAt
          ? _value.incomeAt
          : incomeAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Income implements _Income {
  _$_Income(
      {required this.idx,
      required this.requestIdx,
      required this.income,
      required this.incomeAt});

  factory _$_Income.fromJson(Map<String, dynamic> json) =>
      _$$_IncomeFromJson(json);

  @override
  final int idx;
  @override
  final int requestIdx;
  @override
  final int income;
  @override
  final String incomeAt;

  @override
  String toString() {
    return 'Income(idx: $idx, requestIdx: $requestIdx, income: $income, incomeAt: $incomeAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Income &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.requestIdx, requestIdx) ||
                other.requestIdx == requestIdx) &&
            (identical(other.income, income) || other.income == income) &&
            (identical(other.incomeAt, incomeAt) ||
                other.incomeAt == incomeAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, requestIdx, income, incomeAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IncomeCopyWith<_$_Income> get copyWith =>
      __$$_IncomeCopyWithImpl<_$_Income>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IncomeToJson(
      this,
    );
  }
}

abstract class _Income implements Income {
  factory _Income(
      {required final int idx,
      required final int requestIdx,
      required final int income,
      required final String incomeAt}) = _$_Income;

  factory _Income.fromJson(Map<String, dynamic> json) = _$_Income.fromJson;

  @override
  int get idx;
  @override
  int get requestIdx;
  @override
  int get income;
  @override
  String get incomeAt;
  @override
  @JsonKey(ignore: true)
  _$$_IncomeCopyWith<_$_Income> get copyWith =>
      throw _privateConstructorUsedError;
}
