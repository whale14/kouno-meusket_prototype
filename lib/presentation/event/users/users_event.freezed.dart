// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UsersEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getAroundHelpers,
    required TResult Function(
            String id, String name, double latitude, double longitude)
        insert,
    required TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)
        insertRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getAroundHelpers,
    TResult? Function(
            String id, String name, double latitude, double longitude)?
        insert,
    TResult? Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getAroundHelpers,
    TResult Function(String id, String name, double latitude, double longitude)?
        insert,
    TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAroundHelpers value) getAroundHelpers,
    required TResult Function(Insert value) insert,
    required TResult Function(InsertRequest value) insertRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAroundHelpers value)? getAroundHelpers,
    TResult? Function(Insert value)? insert,
    TResult? Function(InsertRequest value)? insertRequest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAroundHelpers value)? getAroundHelpers,
    TResult Function(Insert value)? insert,
    TResult Function(InsertRequest value)? insertRequest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersEventCopyWith<$Res> {
  factory $UsersEventCopyWith(
          UsersEvent value, $Res Function(UsersEvent) then) =
      _$UsersEventCopyWithImpl<$Res, UsersEvent>;
}

/// @nodoc
class _$UsersEventCopyWithImpl<$Res, $Val extends UsersEvent>
    implements $UsersEventCopyWith<$Res> {
  _$UsersEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GetAroundHelpersCopyWith<$Res> {
  factory _$$GetAroundHelpersCopyWith(
          _$GetAroundHelpers value, $Res Function(_$GetAroundHelpers) then) =
      __$$GetAroundHelpersCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$GetAroundHelpersCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$GetAroundHelpers>
    implements _$$GetAroundHelpersCopyWith<$Res> {
  __$$GetAroundHelpersCopyWithImpl(
      _$GetAroundHelpers _value, $Res Function(_$GetAroundHelpers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$GetAroundHelpers(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetAroundHelpers implements GetAroundHelpers {
  const _$GetAroundHelpers(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'UsersEvent.getAroundHelpers(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAroundHelpers &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAroundHelpersCopyWith<_$GetAroundHelpers> get copyWith =>
      __$$GetAroundHelpersCopyWithImpl<_$GetAroundHelpers>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getAroundHelpers,
    required TResult Function(
            String id, String name, double latitude, double longitude)
        insert,
    required TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)
        insertRequest,
  }) {
    return getAroundHelpers(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getAroundHelpers,
    TResult? Function(
            String id, String name, double latitude, double longitude)?
        insert,
    TResult? Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
  }) {
    return getAroundHelpers?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getAroundHelpers,
    TResult Function(String id, String name, double latitude, double longitude)?
        insert,
    TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
    required TResult orElse(),
  }) {
    if (getAroundHelpers != null) {
      return getAroundHelpers(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAroundHelpers value) getAroundHelpers,
    required TResult Function(Insert value) insert,
    required TResult Function(InsertRequest value) insertRequest,
  }) {
    return getAroundHelpers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAroundHelpers value)? getAroundHelpers,
    TResult? Function(Insert value)? insert,
    TResult? Function(InsertRequest value)? insertRequest,
  }) {
    return getAroundHelpers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAroundHelpers value)? getAroundHelpers,
    TResult Function(Insert value)? insert,
    TResult Function(InsertRequest value)? insertRequest,
    required TResult orElse(),
  }) {
    if (getAroundHelpers != null) {
      return getAroundHelpers(this);
    }
    return orElse();
  }
}

abstract class GetAroundHelpers implements UsersEvent {
  const factory GetAroundHelpers(final String id) = _$GetAroundHelpers;

  String get id;
  @JsonKey(ignore: true)
  _$$GetAroundHelpersCopyWith<_$GetAroundHelpers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertCopyWith<$Res> {
  factory _$$InsertCopyWith(_$Insert value, $Res Function(_$Insert) then) =
      __$$InsertCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String name, double latitude, double longitude});
}

/// @nodoc
class __$$InsertCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$Insert>
    implements _$$InsertCopyWith<$Res> {
  __$$InsertCopyWithImpl(_$Insert _value, $Res Function(_$Insert) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$Insert(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$Insert implements Insert {
  const _$Insert(this.id, this.name, this.latitude, this.longitude);

  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'UsersEvent.insert(id: $id, name: $name, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Insert &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertCopyWith<_$Insert> get copyWith =>
      __$$InsertCopyWithImpl<_$Insert>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getAroundHelpers,
    required TResult Function(
            String id, String name, double latitude, double longitude)
        insert,
    required TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)
        insertRequest,
  }) {
    return insert(id, name, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getAroundHelpers,
    TResult? Function(
            String id, String name, double latitude, double longitude)?
        insert,
    TResult? Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
  }) {
    return insert?.call(id, name, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getAroundHelpers,
    TResult Function(String id, String name, double latitude, double longitude)?
        insert,
    TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
    required TResult orElse(),
  }) {
    if (insert != null) {
      return insert(id, name, latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAroundHelpers value) getAroundHelpers,
    required TResult Function(Insert value) insert,
    required TResult Function(InsertRequest value) insertRequest,
  }) {
    return insert(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAroundHelpers value)? getAroundHelpers,
    TResult? Function(Insert value)? insert,
    TResult? Function(InsertRequest value)? insertRequest,
  }) {
    return insert?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAroundHelpers value)? getAroundHelpers,
    TResult Function(Insert value)? insert,
    TResult Function(InsertRequest value)? insertRequest,
    required TResult orElse(),
  }) {
    if (insert != null) {
      return insert(this);
    }
    return orElse();
  }
}

abstract class Insert implements UsersEvent {
  const factory Insert(final String id, final String name,
      final double latitude, final double longitude) = _$Insert;

  String get id;
  String get name;
  double get latitude;
  double get longitude;
  @JsonKey(ignore: true)
  _$$InsertCopyWith<_$Insert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertRequestCopyWith<$Res> {
  factory _$$InsertRequestCopyWith(
          _$InsertRequest value, $Res Function(_$InsertRequest) then) =
      __$$InsertRequestCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String reqIdx,
      String categoryIdx,
      String title,
      String content,
      String address,
      String latitude,
      String longitude});
}

/// @nodoc
class __$$InsertRequestCopyWithImpl<$Res>
    extends _$UsersEventCopyWithImpl<$Res, _$InsertRequest>
    implements _$$InsertRequestCopyWith<$Res> {
  __$$InsertRequestCopyWithImpl(
      _$InsertRequest _value, $Res Function(_$InsertRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reqIdx = null,
    Object? categoryIdx = null,
    Object? title = null,
    Object? content = null,
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$InsertRequest(
      null == reqIdx
          ? _value.reqIdx
          : reqIdx // ignore: cast_nullable_to_non_nullable
              as String,
      null == categoryIdx
          ? _value.categoryIdx
          : categoryIdx // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsertRequest implements InsertRequest {
  const _$InsertRequest(this.reqIdx, this.categoryIdx, this.title, this.content,
      this.address, this.latitude, this.longitude);

  @override
  final String reqIdx;
  @override
  final String categoryIdx;
  @override
  final String title;
  @override
  final String content;
  @override
  final String address;
  @override
  final String latitude;
  @override
  final String longitude;

  @override
  String toString() {
    return 'UsersEvent.insertRequest(reqIdx: $reqIdx, categoryIdx: $categoryIdx, title: $title, content: $content, address: $address, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertRequest &&
            (identical(other.reqIdx, reqIdx) || other.reqIdx == reqIdx) &&
            (identical(other.categoryIdx, categoryIdx) ||
                other.categoryIdx == categoryIdx) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reqIdx, categoryIdx, title,
      content, address, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertRequestCopyWith<_$InsertRequest> get copyWith =>
      __$$InsertRequestCopyWithImpl<_$InsertRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) getAroundHelpers,
    required TResult Function(
            String id, String name, double latitude, double longitude)
        insert,
    required TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)
        insertRequest,
  }) {
    return insertRequest(
        reqIdx, categoryIdx, title, content, address, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? getAroundHelpers,
    TResult? Function(
            String id, String name, double latitude, double longitude)?
        insert,
    TResult? Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
  }) {
    return insertRequest?.call(
        reqIdx, categoryIdx, title, content, address, latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? getAroundHelpers,
    TResult Function(String id, String name, double latitude, double longitude)?
        insert,
    TResult Function(String reqIdx, String categoryIdx, String title,
            String content, String address, String latitude, String longitude)?
        insertRequest,
    required TResult orElse(),
  }) {
    if (insertRequest != null) {
      return insertRequest(
          reqIdx, categoryIdx, title, content, address, latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetAroundHelpers value) getAroundHelpers,
    required TResult Function(Insert value) insert,
    required TResult Function(InsertRequest value) insertRequest,
  }) {
    return insertRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GetAroundHelpers value)? getAroundHelpers,
    TResult? Function(Insert value)? insert,
    TResult? Function(InsertRequest value)? insertRequest,
  }) {
    return insertRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetAroundHelpers value)? getAroundHelpers,
    TResult Function(Insert value)? insert,
    TResult Function(InsertRequest value)? insertRequest,
    required TResult orElse(),
  }) {
    if (insertRequest != null) {
      return insertRequest(this);
    }
    return orElse();
  }
}

abstract class InsertRequest implements UsersEvent {
  const factory InsertRequest(
      final String reqIdx,
      final String categoryIdx,
      final String title,
      final String content,
      final String address,
      final String latitude,
      final String longitude) = _$InsertRequest;

  String get reqIdx;
  String get categoryIdx;
  String get title;
  String get content;
  String get address;
  String get latitude;
  String get longitude;
  @JsonKey(ignore: true)
  _$$InsertRequestCopyWith<_$InsertRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
