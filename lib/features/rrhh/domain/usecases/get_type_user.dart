import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class GetTypeUser implements UseCasesStream<List<TypeUser>, NoParams> {
  final RRHHRepository rrhhRepository;

  GetTypeUser(this.rrhhRepository);
  @override
  Stream<Either<Failure, List<TypeUser>>> call(NoParams noParams) async* {
    yield* rrhhRepository.getTypeUsers()!;
  }
}
