import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, User>> getCurrentUser(String email) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> recoverPassword(String email) {
    // TODO: implement recoverPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithDataUser(
      String name,
      String lastName,
      bool gender,
      String phone,
      String direction,
      bool stateAccount,
      String email) {
    // TODO: implement signUpWithDataUser
    throw UnimplementedError();
  }
}
