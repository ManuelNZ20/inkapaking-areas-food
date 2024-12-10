import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetDetailUserWithTypeUser
    extends UseCases<User, GetDetailUserWithTypeUserParams> {
  final RRHHRepository rhhRepository;

  GetDetailUserWithTypeUser(this.rhhRepository);

  @override
  Future<Either<Failure, User>> call(
      GetDetailUserWithTypeUserParams params) async {
    return await rhhRepository.getDetailUserWithTypeUser(params.userId)!;
  }
}

class GetDetailUserWithTypeUserParams {
  final int userId;

  GetDetailUserWithTypeUserParams({
    required this.userId,
  });
}
