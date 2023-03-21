import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_event.freezed.dart';

@freezed
abstract class RequestEvent<T> with _$RequestEvent<T> {
  const factory RequestEvent.getRequests(String idx) = GetRequests;
  const factory RequestEvent.getMyRequestsRequesterSide(String idx) = GetMyRequestsRequesterSide;
  const factory RequestEvent.getMyRequestsWorkerSide(String idx) = GetMyRequestsWorkerSide;
  const factory RequestEvent.acceptRequest(String idx, String workerIdx) = AccpetRequest;
}