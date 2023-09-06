// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get idx => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get createAt => throw _privateConstructorUsedError;
  String get updateAt => throw _privateConstructorUsedError;
  int get doingState => throw _privateConstructorUsedError;
  int get accountState => throw _privateConstructorUsedError;
  int get isRequesterRegist => throw _privateConstructorUsedError;
  int get isWorkerRegist => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get introduce => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get transportation => throw _privateConstructorUsedError;
  String? get workCategory => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;
  int? get requestRequesterCount => throw _privateConstructorUsedError;
  int? get requestWorkerCount => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  int? get money => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int idx,
      String id,
      String name,
      double latitude,
      double longitude,
      String createAt,
      String updateAt,
      int doingState,
      int accountState,
      int isRequesterRegist,
      int isWorkerRegist,
      String? bio,
      String? introduce,
      String? profileImageUrl,
      String? transportation,
      String? workCategory,
      String fcmToken,
      int? requestRequesterCount,
      int? requestWorkerCount,
      String age,
      String gender,
      double? distance,
      int? money});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? createAt = null,
    Object? updateAt = null,
    Object? doingState = null,
    Object? accountState = null,
    Object? isRequesterRegist = null,
    Object? isWorkerRegist = null,
    Object? bio = freezed,
    Object? introduce = freezed,
    Object? profileImageUrl = freezed,
    Object? transportation = freezed,
    Object? workCategory = freezed,
    Object? fcmToken = null,
    Object? requestRequesterCount = freezed,
    Object? requestWorkerCount = freezed,
    Object? age = null,
    Object? gender = null,
    Object? distance = freezed,
    Object? money = freezed,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: null == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String,
      doingState: null == doingState
          ? _value.doingState
          : doingState // ignore: cast_nullable_to_non_nullable
              as int,
      accountState: null == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as int,
      isRequesterRegist: null == isRequesterRegist
          ? _value.isRequesterRegist
          : isRequesterRegist // ignore: cast_nullable_to_non_nullable
              as int,
      isWorkerRegist: null == isWorkerRegist
          ? _value.isWorkerRegist
          : isWorkerRegist // ignore: cast_nullable_to_non_nullable
              as int,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      introduce: freezed == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      transportation: freezed == transportation
          ? _value.transportation
          : transportation // ignore: cast_nullable_to_non_nullable
              as String?,
      workCategory: freezed == workCategory
          ? _value.workCategory
          : workCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      requestRequesterCount: freezed == requestRequesterCount
          ? _value.requestRequesterCount
          : requestRequesterCount // ignore: cast_nullable_to_non_nullable
              as int?,
      requestWorkerCount: freezed == requestWorkerCount
          ? _value.requestWorkerCount
          : requestWorkerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      String id,
      String name,
      double latitude,
      double longitude,
      String createAt,
      String updateAt,
      int doingState,
      int accountState,
      int isRequesterRegist,
      int isWorkerRegist,
      String? bio,
      String? introduce,
      String? profileImageUrl,
      String? transportation,
      String? workCategory,
      String fcmToken,
      int? requestRequesterCount,
      int? requestWorkerCount,
      String age,
      String gender,
      double? distance,
      int? money});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? createAt = null,
    Object? updateAt = null,
    Object? doingState = null,
    Object? accountState = null,
    Object? isRequesterRegist = null,
    Object? isWorkerRegist = null,
    Object? bio = freezed,
    Object? introduce = freezed,
    Object? profileImageUrl = freezed,
    Object? transportation = freezed,
    Object? workCategory = freezed,
    Object? fcmToken = null,
    Object? requestRequesterCount = freezed,
    Object? requestWorkerCount = freezed,
    Object? age = null,
    Object? gender = null,
    Object? distance = freezed,
    Object? money = freezed,
  }) {
    return _then(_$_User(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as String,
      updateAt: null == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as String,
      doingState: null == doingState
          ? _value.doingState
          : doingState // ignore: cast_nullable_to_non_nullable
              as int,
      accountState: null == accountState
          ? _value.accountState
          : accountState // ignore: cast_nullable_to_non_nullable
              as int,
      isRequesterRegist: null == isRequesterRegist
          ? _value.isRequesterRegist
          : isRequesterRegist // ignore: cast_nullable_to_non_nullable
              as int,
      isWorkerRegist: null == isWorkerRegist
          ? _value.isWorkerRegist
          : isWorkerRegist // ignore: cast_nullable_to_non_nullable
              as int,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      introduce: freezed == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      transportation: freezed == transportation
          ? _value.transportation
          : transportation // ignore: cast_nullable_to_non_nullable
              as String?,
      workCategory: freezed == workCategory
          ? _value.workCategory
          : workCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
      requestRequesterCount: freezed == requestRequesterCount
          ? _value.requestRequesterCount
          : requestRequesterCount // ignore: cast_nullable_to_non_nullable
              as int?,
      requestWorkerCount: freezed == requestWorkerCount
          ? _value.requestWorkerCount
          : requestWorkerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  _$_User(
      {required this.idx,
      required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.createAt,
      required this.updateAt,
      required this.doingState,
      required this.accountState,
      required this.isRequesterRegist,
      required this.isWorkerRegist,
      required this.bio,
      required this.introduce,
      required this.profileImageUrl,
      required this.transportation,
      required this.workCategory,
      required this.fcmToken,
      required this.requestRequesterCount,
      required this.requestWorkerCount,
      required this.age,
      required this.gender,
      required this.distance,
      required this.money});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final int idx;
  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String createAt;
  @override
  final String updateAt;
  @override
  final int doingState;
  @override
  final int accountState;
  @override
  final int isRequesterRegist;
  @override
  final int isWorkerRegist;
  @override
  final String? bio;
  @override
  final String? introduce;
  @override
  final String? profileImageUrl;
  @override
  final String? transportation;
  @override
  final String? workCategory;
  @override
  final String fcmToken;
  @override
  final int? requestRequesterCount;
  @override
  final int? requestWorkerCount;
  @override
  final String age;
  @override
  final String gender;
  @override
  final double? distance;
  @override
  final int? money;

  @override
  String toString() {
    return 'User(idx: $idx, id: $id, name: $name, latitude: $latitude, longitude: $longitude, createAt: $createAt, updateAt: $updateAt, doingState: $doingState, accountState: $accountState, isRequesterRegist: $isRequesterRegist, isWorkerRegist: $isWorkerRegist, bio: $bio, introduce: $introduce, profileImageUrl: $profileImageUrl, transportation: $transportation, workCategory: $workCategory, fcmToken: $fcmToken, requestRequesterCount: $requestRequesterCount, requestWorkerCount: $requestWorkerCount, age: $age, gender: $gender, distance: $distance, money: $money)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.doingState, doingState) ||
                other.doingState == doingState) &&
            (identical(other.accountState, accountState) ||
                other.accountState == accountState) &&
            (identical(other.isRequesterRegist, isRequesterRegist) ||
                other.isRequesterRegist == isRequesterRegist) &&
            (identical(other.isWorkerRegist, isWorkerRegist) ||
                other.isWorkerRegist == isWorkerRegist) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.introduce, introduce) ||
                other.introduce == introduce) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.transportation, transportation) ||
                other.transportation == transportation) &&
            (identical(other.workCategory, workCategory) ||
                other.workCategory == workCategory) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.requestRequesterCount, requestRequesterCount) ||
                other.requestRequesterCount == requestRequesterCount) &&
            (identical(other.requestWorkerCount, requestWorkerCount) ||
                other.requestWorkerCount == requestWorkerCount) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.money, money) || other.money == money));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        idx,
        id,
        name,
        latitude,
        longitude,
        createAt,
        updateAt,
        doingState,
        accountState,
        isRequesterRegist,
        isWorkerRegist,
        bio,
        introduce,
        profileImageUrl,
        transportation,
        workCategory,
        fcmToken,
        requestRequesterCount,
        requestWorkerCount,
        age,
        gender,
        distance,
        money
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final int idx,
      required final String id,
      required final String name,
      required final double latitude,
      required final double longitude,
      required final String createAt,
      required final String updateAt,
      required final int doingState,
      required final int accountState,
      required final int isRequesterRegist,
      required final int isWorkerRegist,
      required final String? bio,
      required final String? introduce,
      required final String? profileImageUrl,
      required final String? transportation,
      required final String? workCategory,
      required final String fcmToken,
      required final int? requestRequesterCount,
      required final int? requestWorkerCount,
      required final String age,
      required final String gender,
      required final double? distance,
      required final int? money}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  int get idx;
  @override
  String get id;
  @override
  String get name;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get createAt;
  @override
  String get updateAt;
  @override
  int get doingState;
  @override
  int get accountState;
  @override
  int get isRequesterRegist;
  @override
  int get isWorkerRegist;
  @override
  String? get bio;
  @override
  String? get introduce;
  @override
  String? get profileImageUrl;
  @override
  String? get transportation;
  @override
  String? get workCategory;
  @override
  String get fcmToken;
  @override
  int? get requestRequesterCount;
  @override
  int? get requestWorkerCount;
  @override
  String get age;
  @override
  String get gender;
  @override
  double? get distance;
  @override
  int? get money;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
