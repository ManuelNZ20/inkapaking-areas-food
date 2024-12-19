import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetMyOrdersByUserId
    extends UseCases<List<MyOrder>, GetMyOrdersByUserIdParams> {
  final MyOrderRepository repository;

  GetMyOrdersByUserId(this.repository);

  @override
  Future<Either<Failure, List<MyOrder>>> call(
      GetMyOrdersByUserIdParams params) async {
    return await repository.listMyOrders(params.userId)!;
  }
}

class GetMyOrdersByUserIdParams {
  final int userId;

  GetMyOrdersByUserIdParams({required this.userId});
}
