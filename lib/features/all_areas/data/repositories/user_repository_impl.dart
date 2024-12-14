import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _handleNetworkRequest<T>(
      Future<T> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await request();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on GenericException catch (e) {
        return Left(CustomFailure(e.toString()));
      }
    } else {
      return Left(ServerFailure('No hay conexión a Internet'));
    }
  }

  @override
  Future<Either<Failure, List<User>>>? getUsers(int typeUserId) async {
    return _handleNetworkRequest(
      () async {
        return await userRemoteDataSource.getUsers(typeUserId)!;
      },
    );
  }

  @override
  Future<Either<Failure, User>>? getUserById(int id) async {
    return _handleNetworkRequest(
      () async {
        return await userRemoteDataSource.getUserById(id)!;
      },
    );
  }
}
