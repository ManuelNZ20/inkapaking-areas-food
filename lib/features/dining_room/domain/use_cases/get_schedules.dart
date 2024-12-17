import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetSchedules extends UseCases<List<Schedule>, NoParams> {
  final DiningRoomRepository repository;

  GetSchedules(this.repository);

  @override
  Future<Either<Failure, List<Schedule>>> call(NoParams params) async {
    return await repository.listSchedules()!;
  }
}
