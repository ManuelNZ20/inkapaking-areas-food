import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetSaucerById extends UseCases<Saucer, GetSaucerByIdParams> {
  final DiningRoomRepository repository;

  GetSaucerById(this.repository);

  @override
  Future<Either<Failure, Saucer>> call(GetSaucerByIdParams params) async {
    return await repository.getSaucerById(params.saucerId)!;
  }
}

class GetSaucerByIdParams {
  final int saucerId;

  GetSaucerByIdParams(this.saucerId);
}
