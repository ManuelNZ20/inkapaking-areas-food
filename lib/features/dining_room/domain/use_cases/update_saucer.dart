import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class UpdateSaucer extends UseCases<Saucer, UpdateSaucerParams> {
  final DiningRoomRepository repository;

  UpdateSaucer(this.repository);

  @override
  Future<Either<Failure, Saucer>> call(UpdateSaucerParams params) async {
    return await repository.updateSaucer(
      params.saucerId,
      params.nameSaucer,
      params.nameDrink,
      params.scheduleId,
      params.updateAt,
    )!;
  }
}

class UpdateSaucerParams {
  final int saucerId;
  final String nameSaucer;
  final String nameDrink;
  final int scheduleId;
  final String updateAt;

  UpdateSaucerParams({
    required this.saucerId,
    required this.nameSaucer,
    required this.nameDrink,
    required this.scheduleId,
    required this.updateAt,
  });
}
