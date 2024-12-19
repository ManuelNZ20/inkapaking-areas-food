import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetLastGeneralOrderStream
    extends UseCasesStream<GeneralOrder, GetLastGeneralOrderStreamParams> {
  final DiningRoomRepository repository;

  GetLastGeneralOrderStream(this.repository);

  @override
  Stream<Either<Failure, GeneralOrder>> call(
      GetLastGeneralOrderStreamParams params) async* {
    yield* repository.getLastGeneralOrderStream(
      params.date,
    )!;
  }
}

class GetLastGeneralOrderStreamParams {
  final String date;

  GetLastGeneralOrderStreamParams({
    required this.date,
  });
}
