import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetCurrentUser implements AuthUseCase<User, GetCurrentUserParams> {
  final AuthRepository authRepository;

  GetCurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(GetCurrentUserParams params) async {
    return await authRepository.getCurrentUser(
      params.email,
    );
  }
}

class GetCurrentUserParams {
  final String email;

  GetCurrentUserParams({
    required this.email,
  });
}
