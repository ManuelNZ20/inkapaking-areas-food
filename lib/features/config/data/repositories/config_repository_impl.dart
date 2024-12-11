import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class ConfigRepositoryImpl extends ConfigRepository {
  final ConfigDataSources configDataSource;
  final NetworkInfo networkInfo;

  ConfigRepositoryImpl({
    required this.configDataSource,
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
      return Left(
        ServerFailure('No hay conexión a Internet'),
      );
    }
  }

  @override
  Future<Either<Failure, User>>? configGetUserById(int userId) async {
    return _handleNetworkRequest(
      () async {
        return await configDataSource.configGetUserById(
          userId,
        )!;
      },
    );
  }

  @override
  Future<Either<Failure, User>>? configUpdateData(
      int userId,
      String email,
      String name,
      String lastName,
      bool gender,
      String phone,
      String direction,
      String password) async {
    return _handleNetworkRequest(() async {
      return await configDataSource.configUpdateData(
        userId,
        email,
        name,
        lastName,
        gender,
        phone,
        direction,
        password,
      )!;
    });
  }
}
