import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../domain.dart';

class GetAcceptedRequests extends UseCases<List<RequestUser>, NoParams> {
  final RRHHRepository rrhhRepository;

  GetAcceptedRequests(this.rrhhRepository);

  @override
  Future<Either<Failure, List<RequestUser>>> call(NoParams params) async {
    return await rrhhRepository.getAcceptedRequests()!;
  }
}
