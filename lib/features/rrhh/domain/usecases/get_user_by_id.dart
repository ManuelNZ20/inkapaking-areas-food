import 'package:dartz/dartz.dart';

import 'package:inkapaking/core/core.dart';
import '../domain.dart';

class GetUserById implements UseCases<User, GetUserByIdParams> {
  final RRHHRepository rrhhRepository;

  GetUserById(
    this.rrhhRepository,
  );

  @override
  Future<Either<Failure, User>> call(GetUserByIdParams params) {
    return rrhhRepository.getUserById(params.userId)!;
  }
}

class GetUserByIdParams {
  final int userId;

  GetUserByIdParams({required this.userId});
}
