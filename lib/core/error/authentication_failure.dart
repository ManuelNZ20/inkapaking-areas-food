import 'failures.dart';

class AuthenticationFailure extends Failure {
  AuthenticationFailure([String message = 'Invalid credentials'])
      : super([message]);
}
