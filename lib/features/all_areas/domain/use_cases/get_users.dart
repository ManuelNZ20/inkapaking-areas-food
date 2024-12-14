import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetUsers extends UseCases<List<User>, GetUsersParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(GetUsersParams params) async {
    return repository.getUsers(params.typeUserId)!;
  }
}

class GetUsersParams {
  final int typeUserId;

  GetUsersParams({
    required this.typeUserId,
  });
}
