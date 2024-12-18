import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetLastGeneralOrder
    extends UseCases<GeneralOrder, GetLastGeneralOrderParams> {
  final DiningRoomRepository repository;

  GetLastGeneralOrder(this.repository);

  @override
  Future<Either<Failure, GeneralOrder>> call(
      GetLastGeneralOrderParams params) async {
    return await repository.getLastGeneralOrder(
      params.createdAt,
    )!;
  }
}

class GetLastGeneralOrderParams {
  final String createdAt;

  GetLastGeneralOrderParams({
    required this.createdAt,
  });
}
