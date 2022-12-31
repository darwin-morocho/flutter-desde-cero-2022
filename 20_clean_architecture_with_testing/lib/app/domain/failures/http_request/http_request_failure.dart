import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {
  factory HttpRequestFailure.notFound() = HttpRequestFailureNotFound;
  factory HttpRequestFailure.network() = HttpRequestFailureNetwork;
  factory HttpRequestFailure.unauthorized() = HttpRequestFailureUnauthorized;
  factory HttpRequestFailure.unknown() = HttpRequestFailureUnknown;
}
