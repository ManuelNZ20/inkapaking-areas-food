import 'failure.dart';

class AuthenticationFailure extends Failure {
  AuthenticationFailure([String message = 'Invalid credentials'])
      : super([message]);

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  String toString() => 'Fallo de autenticación credenciales inválidas';
}
