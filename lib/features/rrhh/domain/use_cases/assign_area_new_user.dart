import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

class AssignAreaNewUser extends UseCases<User, AssignAreaNewUserParams> {
  final RRHHRepository rrhhRepository;

  AssignAreaNewUser(this.rrhhRepository);
  @override
  Future<Either<Failure, User>> call(AssignAreaNewUserParams params) async {
    return await rrhhRepository.assignAreaToUser(
      params.userId,
      params.areaId,
    )!;
  }
}

class AssignAreaNewUserParams {
  final int userId;
  final int areaId;

  AssignAreaNewUserParams({
    required this.userId,
    required this.areaId,
  });
}
