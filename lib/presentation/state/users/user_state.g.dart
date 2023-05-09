// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState<T> _$$_UserStateFromJson<T>(Map<String, dynamic> json) =>
    _$_UserState<T>(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserStateToJson<T>(_$_UserState<T> instance) =>
    <String, dynamic>{
      'user': instance.user,
      'isLoading': instance.isLoading,
    };
