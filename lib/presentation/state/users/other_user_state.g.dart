// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OtherUserState _$$_OtherUserStateFromJson(Map<String, dynamic> json) =>
    _$_OtherUserState(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$_OtherUserStateToJson(_$_OtherUserState instance) =>
    <String, dynamic>{
      'user': instance.user,
      'isLoading': instance.isLoading,
    };
