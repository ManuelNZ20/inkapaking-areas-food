import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthSupabaseDataSource supabaseDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.supabaseDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>>? getCurrentUser(
    String email,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await supabaseDataSource.getCurrentUser(email);
        localDataSource.saveCurrentUser(remoteUser);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getCurrentUser();
        return Right(localUser!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>>? recoverPassword(String email) {
    // TODO: implement recoverPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>>? signInWithEmailAndPassword(
      String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>>? signOut() {
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
