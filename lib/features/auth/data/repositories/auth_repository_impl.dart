import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthSupabaseDataSource supabaseDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.supabaseDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _handleNetworkRequest<T>(
      Future<T> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await request();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message)); // Mensaje más descriptivo
      } catch (e) {
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
      final remoteUser = await supabaseDataSource.getCurrentUser(email);
      localDataSource.saveCurrentUser(remoteUser!);
      return remoteUser;
    });
  }

  @override
  Future<Either<Failure, bool>>? recoverPassword(String email) async {
    return _handleNetworkRequest(() async {
      return await supabaseDataSource.recoverPassword(email) ?? false;
    });
  }

  @override
  Future<Either<Failure, User>>? signInWithEmailAndPassword(
      String email, String password) async {
    return _handleNetworkRequest(() async {
      final remoteUser =
          await supabaseDataSource.signInWithEmailAndPassword(email, password);
      localDataSource.saveCurrentUser(remoteUser!);
      return remoteUser;
    });
  }

  @override
  Future<Either<Failure, User>>? signOut() async {
    return _handleNetworkRequest(() async {
      final remoteUser = await supabaseDataSource.signOut();
      localDataSource.deleteCurrentUser();
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
      return await supabaseDataSource.signUpWithDataUser(
          name, lastName, gender, phone, direction, stateAccount, email)!;
    });
  }
}
