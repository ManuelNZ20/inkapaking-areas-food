import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class RecoverPassword implements AuthUseCase<bool, RecoverPasswordParams> {
  final AuthRepository authRepository;

  RecoverPassword(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(RecoverPasswordParams params) async {
    final email = InputEmail.dirty(params.email);
    final password = InputPassword.dirty(params.newPassword);
    if (email.isValid && password.isValid) {
      return authRepository.recoverPassword(
        params.email,
        params.newPassword,
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

class RecoverPasswordParams {
  final String email;
  final String newPassword;
  RecoverPasswordParams({
    required this.email,
    required this.newPassword,
  });
}
