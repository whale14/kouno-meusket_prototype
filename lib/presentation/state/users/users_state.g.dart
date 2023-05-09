// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UsersState _$$_UsersStateFromJson(Map<String, dynamic> json) =>
    _$_UsersState(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
      myIdx: json['myIdx'] as String? ?? '',
    );

Map<String, dynamic> _$$_UsersStateToJson(_$_UsersState instance) =>
    <String, dynamic>{
      'users': instance.users,
      'isLoading': instance.isLoading,
      'myIdx': instance.myIdx,
    };
