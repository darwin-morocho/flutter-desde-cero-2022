part of 'http.dart';

class HttpFailure {
  HttpFailure({
    this.statusCode,
    this.exception,
    this.data,
  });

  final int? statusCode;
  final Object? exception;
  final Object? data;
}

class NetworkException {}
