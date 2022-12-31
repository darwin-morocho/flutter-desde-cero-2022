import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  factory SignInFailure.notFound() = SignInFailureNotFound;
  factory SignInFailure.notVerified() = SignInFailureNotVerified;
  factory SignInFailure.network() = SignInFailureNetwork;
  factory SignInFailure.unauthorized() = SignInFailureUnauthorized;
  factory SignInFailure.unknown() = SignInFailureUnknown;
}
