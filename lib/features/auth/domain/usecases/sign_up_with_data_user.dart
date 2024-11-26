import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class SignUpWithDataUser
    implements AuthUseCase<User, SignUpWithDataUserParams> {
  final AuthRepository repository;

  SignUpWithDataUser(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpWithDataUserParams params) async {
    return repository.signUpWithDataUser(
      params.name,
      params.lastName,
      params.gender,
      params.phone,
      params.direction,
      params.stateAccount,
      params.email,
    )!;
  }
}

class SignUpWithDataUserParams {
  final String name;
  final String lastName;
  final bool gender;
  final String phone;
  final String direction;
  final bool stateAccount;
  final String email;

  SignUpWithDataUserParams({
    required this.name,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.direction,
    required this.stateAccount,
    required this.email,
  });
}
