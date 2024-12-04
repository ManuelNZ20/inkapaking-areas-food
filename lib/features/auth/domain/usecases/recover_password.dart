import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class RecoverPassword implements AuthUseCase<bool, RecoverPasswordParams> {
  final AuthRepository authRepository;

  RecoverPassword(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(RecoverPasswordParams params) async {
    final email = InputEmail.dirty(params.email);

    if (email.isValid) {
      return authRepository.recoverPassword(
        params.email,
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
  RecoverPasswordParams({
    required this.email,
  });
}
