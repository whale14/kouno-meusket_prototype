import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/request/request.dart';

part 'request_state.freezed.dart';

part 'request_state.g.dart';

@freezed
class RequestState with _$RequestState {
  factory RequestState({
    @Default([]) List<Request> requests,
  }) = _RequestState;

  factory RequestState.fromJson(Map<String, dynamic> json) => _$RequestStateFromJson(json);
}