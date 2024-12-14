import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

class UpdateDataUser implements UseCases<User, UpdateDataUserParams> {
  final ConfigRepository configRepository;

  UpdateDataUser(this.configRepository);
  @override
  Future<Either<Failure, User>> call(UpdateDataUserParams params) async {
    return await configRepository.configUpdateData(
      params.userId,
      params.email,
      params.name,
      params.lastName,
      params.gender,
      params.phone,
      params.direction,
      params.password,
    )!;
  }
}

class UpdateDataUserParams {
  final int userId;
  final String email;
  final String name;
  final String lastName;
  final bool gender;
  final String phone;
  final String direction;
  final String password;

  UpdateDataUserParams({
    required this.userId,
    required this.email,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.direction,
    required this.password,
  });
}
