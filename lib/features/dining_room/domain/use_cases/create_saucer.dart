import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class CreateSaucer extends UseCases<Saucer, CreateSaucerParams> {
  final DiningRoomRepository repository;

  CreateSaucer(this.repository);

  @override
  Future<Either<Failure, Saucer>> call(CreateSaucerParams params) async {
    return await repository.createSaucer(
      params.nameSaucer,
      params.nameDrink,
      params.scheduleId,
      params.createdAt,
    )!;
  }
}

class CreateSaucerParams {
  final String nameSaucer;
  final String nameDrink;
  final int scheduleId;
  final String createdAt;

  CreateSaucerParams({
    required this.nameSaucer,
    required this.nameDrink,
    required this.scheduleId,
    required this.createdAt,
  });
}
