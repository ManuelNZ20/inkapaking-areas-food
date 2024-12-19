import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetTodayGeneralOrder
    extends UseCases<GeneralOrder, GetTodayGeneralOrderParams> {
  final DiningRoomRepository repository;

  GetTodayGeneralOrder(this.repository);

  @override
  Future<Either<Failure, GeneralOrder>> call(
      GetTodayGeneralOrderParams params) async {
    return await repository.getTodayGeneralOrder(
      params.createAt,
    )!;
  }
}

class GetTodayGeneralOrderParams {
  final String createAt;

  GetTodayGeneralOrderParams({
    required this.createAt,
  });
}
