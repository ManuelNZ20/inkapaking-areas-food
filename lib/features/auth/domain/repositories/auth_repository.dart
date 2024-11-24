import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';

abstract class AuthRepository {
  // Sign in with email and password
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password});
  // Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String lastName,
    required bool gender,
    required String phone,
    required String direction,
    required bool stateAccount,
    required String email,
  });
  // Sign out
  Future<Either<Failure, User>> signOut();
  // Get the current user
  Future<Either<Failure, User>> getCurrentUser({
    required String email,
  });
  // Recover the password by sending a recovery token to the email.
  Future<Either<Failure, bool>> recoverPassword({
    required String email,
  });
}
