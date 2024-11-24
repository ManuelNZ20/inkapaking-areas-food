import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository authRepository;

  SignInWithEmailAndPassword(this.authRepository);

  Future<Either<Failure, User>> execute({
    required String email,
    required String password,
  }) async {
    return await authRepository.signInWithEmailAndPassword(
      email,
      password,
    );
  }
}
