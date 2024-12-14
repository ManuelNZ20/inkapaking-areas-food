import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class GetTypeUsers implements UseCasesStream<List<TypeUser>, NoParams> {
  final RRHHRepository rrhhRepository;

  GetTypeUsers(this.rrhhRepository);
  @override
  Stream<Either<Failure, List<TypeUser>>> call(NoParams noParams) async* {
    yield* rrhhRepository.getTypeUsers()!;
  }
}
