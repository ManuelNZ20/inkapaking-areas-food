import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class SignOut implements AuthUseCase<User, NoParams> {
  final AuthRepository authRepository;

  SignOut(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
