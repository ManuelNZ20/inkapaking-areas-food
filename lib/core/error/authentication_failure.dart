import 'failures.dart';

class AuthenticationFailure extends Failure {
  AuthenticationFailure([String message = 'Invalid credentials'])
      : super([message]);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
