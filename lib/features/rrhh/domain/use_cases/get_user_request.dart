import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetRequestUser implements UseCasesStream<List<RequestUser>, NoParams> {
  final RRHHRepository rrhhRepository;

  GetRequestUser(this.rrhhRepository);
  @override
  Stream<Either<Failure, List<RequestUser>>> call(NoParams params) async* {
    yield* rrhhRepository.getUserRequests()!;
  }
}
