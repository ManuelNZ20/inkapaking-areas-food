import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetSaucersByScheduleId
    extends UseCases<List<Saucer>, GetSaucersByScheduleIdParams> {
  final DiningRoomRepository repository;

  GetSaucersByScheduleId(this.repository);

  @override
  Future<Either<Failure, List<Saucer>>> call(
      GetSaucersByScheduleIdParams params) async {
    return await repository.getSaucersByScheduleId(
      params.scheduleId,
      params.from,
      params.to,
    )!;
  }
}

class GetSaucersByScheduleIdParams {
  final int scheduleId;
  final int from;
  final int to;
  GetSaucersByScheduleIdParams({
    required this.scheduleId,
    required this.from,
    required this.to,
  });
}
