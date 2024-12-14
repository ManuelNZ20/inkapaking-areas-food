import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

class GetUserById implements UseCases<User, GetUserByIdParams> {
  final ConfigRepository configRepository;

  GetUserById(this.configRepository);

  @override
  Future<Either<Failure, User>> call(GetUserByIdParams noParams) {
    return configRepository.configGetUserById(noParams.userId)!;
  }
}

class GetUserByIdParams {
  final int userId;

  GetUserByIdParams({required this.userId});
}
