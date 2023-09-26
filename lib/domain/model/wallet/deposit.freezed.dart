// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deposit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Deposit _$DepositFromJson(Map<String, dynamic> json) {
  return _Deposit.fromJson(json);
}

/// @nodoc
mixin _$Deposit {
  int get idx => throw _privateConstructorUsedError;
  int get userIdx => throw _privateConstructorUsedError;
  int get paymentType => throw _privateConstructorUsedError;
  int get deposit => throw _privateConstructorUsedError;
  String get depositAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepositCopyWith<Deposit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepositCopyWith<$Res> {
  factory $DepositCopyWith(Deposit value, $Res Function(Deposit) then) =
      _$DepositCopyWithImpl<$Res, Deposit>;
  @useResult
  $Res call(
      {int idx, int userIdx, int paymentType, int deposit, String depositAt});
}

/// @nodoc
class _$DepositCopyWithImpl<$Res, $Val extends Deposit>
    implements $DepositCopyWith<$Res> {
  _$DepositCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? userIdx = null,
    Object? paymentType = null,
    Object? deposit = null,
    Object? depositAt = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      userIdx: null == userIdx
          ? _value.userIdx
          : userIdx // ignore: cast_nullable_to_non_nullable
              as int,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int,
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int,
      depositAt: null == depositAt
          ? _value.depositAt
          : depositAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepositCopyWith<$Res> implements $DepositCopyWith<$Res> {
  factory _$$_DepositCopyWith(
          _$_Deposit value, $Res Function(_$_Deposit) then) =
      __$$_DepositCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx, int userIdx, int paymentType, int deposit, String depositAt});
}

/// @nodoc
class __$$_DepositCopyWithImpl<$Res>
    extends _$DepositCopyWithImpl<$Res, _$_Deposit>
    implements _$$_DepositCopyWith<$Res> {
  __$$_DepositCopyWithImpl(_$_Deposit _value, $Res Function(_$_Deposit) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? userIdx = null,
    Object? paymentType = null,
    Object? deposit = null,
    Object? depositAt = null,
  }) {
    return _then(_$_Deposit(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      userIdx: null == userIdx
          ? _value.userIdx
          : userIdx // ignore: cast_nullable_to_non_nullable
              as int,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int,
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as int,
      depositAt: null == depositAt
          ? _value.depositAt
          : depositAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Deposit implements _Deposit {
  _$_Deposit(
      {required this.idx,
      required this.userIdx,
      required this.paymentType,
      required this.deposit,
      required this.depositAt});

  factory _$_Deposit.fromJson(Map<String, dynamic> json) =>
      _$$_DepositFromJson(json);

  @override
  final int idx;
  @override
  final int userIdx;
  @override
  final int paymentType;
  @override
  final int deposit;
  @override
  final String depositAt;

  @override
  String toString() {
    return 'Deposit(idx: $idx, userIdx: $userIdx, paymentType: $paymentType, deposit: $deposit, depositAt: $depositAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Deposit &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.userIdx, userIdx) || other.userIdx == userIdx) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.depositAt, depositAt) ||
                other.depositAt == depositAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, userIdx, paymentType, deposit, depositAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepositCopyWith<_$_Deposit> get copyWith =>
      __$$_DepositCopyWithImpl<_$_Deposit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DepositToJson(
      this,
    );
  }
}

abstract class _Deposit implements Deposit {
  factory _Deposit(
      {required final int idx,
      required final int userIdx,
      required final int paymentType,
      required final int deposit,
      required final String depositAt}) = _$_Deposit;

  factory _Deposit.fromJson(Map<String, dynamic> json) = _$_Deposit.fromJson;

  @override
  int get idx;
  @override
  int get userIdx;
  @override
  int get paymentType;
  @override
  int get deposit;
  @override
  String get depositAt;
  @override
  @JsonKey(ignore: true)
  _$$_DepositCopyWith<_$_Deposit> get copyWith =>
      throw _privateConstructorUsedError;
}
