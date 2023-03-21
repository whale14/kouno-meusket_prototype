import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_event.freezed.dart';


@freezed
class TestEvent with _$TestEvent {
  const factory TestEvent.getTests() = getTests;
}