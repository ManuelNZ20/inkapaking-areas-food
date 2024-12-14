import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetUserById extends UseCases<User, GetUserByIdParams> {
  final UserRepository repository;

  GetUserById(this.repository);

  @override
  Future<Either<Failure, User>> call(GetUserByIdParams params) async {
    return await repository.getUserById(params.userId)!;
  }
}

class GetUserByIdParams {
  final int userId;

  GetUserByIdParams({
    required this.userId,
  });
}
