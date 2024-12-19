import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class CreateMyOrder extends UseCases<bool, CreateMyOrderParams> {
  final MyOrderRepository repository;

  CreateMyOrder(this.repository);

  @override
  Future<Either<Failure, bool>> call(CreateMyOrderParams params) async {
    return await repository.registerOrder(
      params.breakfast,
      params.lunch,
      params.dinner,
      params.userId,
      params.createdAt,
    )!;
  }
}

class CreateMyOrderParams {
  final int userId;
  final bool breakfast;
  final bool lunch;
  final bool dinner;
  final String createdAt;

  CreateMyOrderParams({
    required this.userId,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.createdAt,
  });
}
