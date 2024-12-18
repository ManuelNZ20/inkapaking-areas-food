import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class CreateGeneralOrder
    extends UseCases<GeneralOrder, CreateGeneralOrderParams> {
  final DiningRoomRepository repository;

  CreateGeneralOrder(this.repository);

  @override
  Future<Either<Failure, GeneralOrder>> call(
      CreateGeneralOrderParams params) async {
    return await repository.createGeneralOrder(
      params.startDate,
      params.endDate,
      params.createdAt,
    )!;
  }
}

class CreateGeneralOrderParams {
  final String startDate;
  final String endDate;
  final String createdAt;

  CreateGeneralOrderParams({
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });
}
