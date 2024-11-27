import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailAndPassword
    implements AuthUseCase<User, SignInWithEmailAndPasswordParams> {
  final AuthRepository authRepository;

  SignInWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, User>> call(
    SignInWithEmailAndPasswordParams params,
  ) async {
    final email = InputEmail.dirty(params.email);
    final password = InputPassword.dirty(params.password);
    if (email.isValid && password.isValid) {
      return authRepository.signInWithEmailAndPassword(
        params.email,
        params.password,
      )!;
    } else {
      return Left(
        AuthenticationFailure(
          'Email o contraseña incorrectos',
        ),
      );
    }
  }
}

class SignInWithEmailAndPasswordParams {
  final String email;
  final String password;

  SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
