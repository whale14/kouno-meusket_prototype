// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletState _$WalletStateFromJson(Map<String, dynamic> json) {
  return _WalletState.fromJson(json);
}

/// @nodoc
mixin _$WalletState {
  Wallet? get wallet => throw _privateConstructorUsedError;
  List<Deposit> get deposits => throw _privateConstructorUsedError;
  List<Income> get incomes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletStateCopyWith<WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStateCopyWith<$Res> {
  factory $WalletStateCopyWith(
          WalletState value, $Res Function(WalletState) then) =
      _$WalletStateCopyWithImpl<$Res, WalletState>;
  @useResult
  $Res call({Wallet? wallet, List<Deposit> deposits, List<Income> incomes});

  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class _$WalletStateCopyWithImpl<$Res, $Val extends WalletState>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = freezed,
    Object? deposits = null,
    Object? incomes = null,
  }) {
    return _then(_value.copyWith(
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      deposits: null == deposits
          ? _value.deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as List<Deposit>,
      incomes: null == incomes
          ? _value.incomes
          : incomes // ignore: cast_nullable_to_non_nullable
              as List<Income>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WalletCopyWith<$Res>? get wallet {
    if (_value.wallet == null) {
      return null;
    }

    return $WalletCopyWith<$Res>(_value.wallet!, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WalletStateCopyWith<$Res>
    implements $WalletStateCopyWith<$Res> {
  factory _$$_WalletStateCopyWith(
          _$_WalletState value, $Res Function(_$_WalletState) then) =
      __$$_WalletStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Wallet? wallet, List<Deposit> deposits, List<Income> incomes});

  @override
  $WalletCopyWith<$Res>? get wallet;
}

/// @nodoc
class __$$_WalletStateCopyWithImpl<$Res>
    extends _$WalletStateCopyWithImpl<$Res, _$_WalletState>
    implements _$$_WalletStateCopyWith<$Res> {
  __$$_WalletStateCopyWithImpl(
      _$_WalletState _value, $Res Function(_$_WalletState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = freezed,
    Object? deposits = null,
    Object? incomes = null,
  }) {
    return _then(_$_WalletState(
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as Wallet?,
      deposits: null == deposits
          ? _value._deposits
          : deposits // ignore: cast_nullable_to_non_nullable
              as List<Deposit>,
      incomes: null == incomes
          ? _value._incomes
          : incomes // ignore: cast_nullable_to_non_nullable
              as List<Income>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WalletState implements _WalletState {
  _$_WalletState(
      {this.wallet,
      final List<Deposit> deposits = const [],
      final List<Income> incomes = const []})
      : _deposits = deposits,
        _incomes = incomes;

  factory _$_WalletState.fromJson(Map<String, dynamic> json) =>
      _$$_WalletStateFromJson(json);

  @override
  final Wallet? wallet;
  final List<Deposit> _deposits;
  @override
  @JsonKey()
  List<Deposit> get deposits {
    if (_deposits is EqualUnmodifiableListView) return _deposits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deposits);
  }

  final List<Income> _incomes;
  @override
  @JsonKey()
  List<Income> get incomes {
    if (_incomes is EqualUnmodifiableListView) return _incomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomes);
  }

  @override
  String toString() {
    return 'WalletState(wallet: $wallet, deposits: $deposits, incomes: $incomes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletState &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            const DeepCollectionEquality().equals(other._deposits, _deposits) &&
            const DeepCollectionEquality().equals(other._incomes, _incomes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      wallet,
      const DeepCollectionEquality().hash(_deposits),
      const DeepCollectionEquality().hash(_incomes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletStateCopyWith<_$_WalletState> get copyWith =>
      __$$_WalletStateCopyWithImpl<_$_WalletState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletStateToJson(
      this,
    );
  }
}

abstract class _WalletState implements WalletState {
  factory _WalletState(
      {final Wallet? wallet,
      final List<Deposit> deposits,
      final List<Income> incomes}) = _$_WalletState;

  factory _WalletState.fromJson(Map<String, dynamic> json) =
      _$_WalletState.fromJson;

  @override
  Wallet? get wallet;
  @override
  List<Deposit> get deposits;
  @override
  List<Income> get incomes;
  @override
  @JsonKey(ignore: true)
  _$$_WalletStateCopyWith<_$_WalletState> get copyWith =>
      throw _privateConstructorUsedError;
}
