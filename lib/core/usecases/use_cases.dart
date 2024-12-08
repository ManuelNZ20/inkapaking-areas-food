import 'package:dartz/dartz.dart';
import '../core.dart';

abstract class UseCases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
