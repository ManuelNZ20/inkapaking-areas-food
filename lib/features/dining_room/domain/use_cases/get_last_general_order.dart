import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetLastGeneralOrder extends UseCases<bool, GetLastGeneralOrderParams> {
  final DiningRoomRepository repository;

  GetLastGeneralOrder(this.repository);

  @override
  Future<Either<Failure, bool>> call(GetLastGeneralOrderParams params) async {
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
