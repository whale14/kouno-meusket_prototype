// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TestState _$$_TestStateFromJson(Map<String, dynamic> json) => _$_TestState(
      tests: (json['tests'] as List<dynamic>?)
              ?.map((e) => Test.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TestStateToJson(_$_TestState instance) =>
    <String, dynamic>{
      'tests': instance.tests,
      'isLoading': instance.isLoading,
    };
