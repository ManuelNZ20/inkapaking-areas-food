import 'package:dartz/dartz.dart';
import '../core.dart';

abstract class AuthUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
