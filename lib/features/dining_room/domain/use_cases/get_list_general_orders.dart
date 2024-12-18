import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetListGeneralOrders extends UseCases<List<GeneralOrder>, NoParams> {
  final DiningRoomRepository repository;

  GetListGeneralOrders(this.repository);

  @override
  Future<Either<Failure, List<GeneralOrder>>> call(NoParams params) async {
    return await repository.listGeneralOrders()!;
  }
}
