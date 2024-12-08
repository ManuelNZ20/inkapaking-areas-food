import 'package:dartz/dartz.dart';
import '../core.dart';

abstract class UseCasesStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
