import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';

abstract class AuthRepository {
  // Sign in with email and password
  Future<Either<Failure, User>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  // Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
    String name,
    String lastName,
    bool gender,
    String phone,
    String direction,
    bool stateAccount,
    String email,
  );
  // Sign out
  Future<Either<Failure, User>> signOut();
  // Get the current user
  Future<Either<Failure, User>> getCurrentUser(
    String email,
  );
  // Recover the password by sending a recovery token to the email.
  Future<Either<Failure, bool>> recoverPassword(
    String email,
  );
}
