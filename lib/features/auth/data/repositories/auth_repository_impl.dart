import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _handleNetworkRequest<T>(
      Future<T> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await request();
        return Right(result);
      } on UnauthorizedException catch (e) {
        return Left(AuthenticationFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message)); // Mensaje más descriptivo
      } on GenericException catch (e) {
        return Left(
            CustomFailure(e.toString())); // Para capturar errores generales
      }
    } else {
      return Left(ServerFailure("No hay conexión a Internet"));
    }
  }

  @override
  Future<Either<Failure, User>>? getCurrentUser(
    String email,
  ) async {
    return _handleNetworkRequest(() async {
      final remoteUser = await remoteDataSource.getCurrentUser(email);
      return remoteUser!;
    });
  }

  @override
  Future<Either<Failure, bool>>? recoverPassword(
      String email, String newPassword) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.recoverPassword(email, newPassword) ??
          false;
    });
  }

  @override
  Future<Either<Failure, bool>>? sendRecoveryEmail(
      String email, String newPassword) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.sendRecoveryEmail(email, newPassword) ??
          false;
    });
  }

  @override
  Future<Either<Failure, User>>? signInWithEmailAndPassword(
      String email, String password) async {
    return _handleNetworkRequest(() async {
      final remoteUser =
          await remoteDataSource.signInWithEmailAndPassword(email, password);
      return remoteUser!;
    });
  }

  @override
  Future<Either<Failure, User>>? signOut() async {
    return _handleNetworkRequest(() async {
      final remoteUser = await remoteDataSource.signOut();
      return remoteUser!;
    });
  }

  @override
  Future<Either<Failure, User>> signUpWithDataUser(
      String name,
      String lastName,
      bool gender,
      String phone,
      String direction,
      bool stateAccount,
      String email) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.signUpWithDataUser(
          name, lastName, gender, phone, direction, stateAccount, email)!;
    });
  }

  @override
  Future<Either<Failure, User>>? getCurrentUserByToken(int token) async {
    return _handleNetworkRequest(() async {
      final remoteUser = await remoteDataSource.getCurrentUserByToken(token);
      return remoteUser!;
    });
  }

  @override
  Future<Either<Failure, bool>>? updatePassword(
      String email, String newPassword) {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.updatePassword(email, newPassword) ?? false;
    });
  }
}
