// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequestState _$$_RequestStateFromJson(Map<String, dynamic> json) =>
    _$_RequestState(
      requests: (json['requests'] as List<dynamic>?)
              ?.map((e) => Request.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_RequestStateToJson(_$_RequestState instance) =>
    <String, dynamic>{
      'requests': instance.requests,
    };
