import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class AddSaucerToGeneralOrder
    extends UseCases<bool, AddSaucerToGeneralOrderParams> {
  final DiningRoomRepository repository;

  AddSaucerToGeneralOrder(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      AddSaucerToGeneralOrderParams params) async {
    return await repository.addSaucerToGeneralOrder(
      params.generalOrderId,
      params.saucerId,
    )!;
  }
}

class AddSaucerToGeneralOrderParams {
  final int generalOrderId;
  final List<int> saucerId;

  AddSaucerToGeneralOrderParams({
    required this.generalOrderId,
    required this.saucerId,
  });
}
