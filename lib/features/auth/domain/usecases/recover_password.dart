import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class RecoverPassword implements AuthUseCase<bool, RecoverPasswordParams> {
  final AuthRepository authRepository;

  RecoverPassword(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(RecoverPasswordParams params) async {
    return await authRepository.recoverPassword(
      params.email,
    );
  }
}

class RecoverPasswordParams {
  final String email;

  RecoverPasswordParams({
    required this.email,
  });
}
