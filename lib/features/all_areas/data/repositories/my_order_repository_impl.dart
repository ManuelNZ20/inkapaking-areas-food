import 'package:dartz/dartz.dart';
import 'package:inkapaking/features/dining_room/domain/entities/general_order.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class MyOrderRepositoryImpl implements MyOrderRepository {
  final MyOrderDataSource myOrderDataSource;
  final NetworkInfo networkInfo;

  MyOrderRepositoryImpl({
    required this.networkInfo,
    required this.myOrderDataSource,
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
  Future<Either<Failure, List<GeneralOrder>>> listGeneralOrder(
      String createdAt) async {
    return _handleNetworkRequest(
      () async {
        return await myOrderDataSource.listGeneralOrder(createdAt)!;
      },
    );
  }

  @override
  Future<Either<Failure, List<MyOrder>>> listMyOrders(int userId) async {
    return _handleNetworkRequest(
      () async {
        return await myOrderDataSource.listMyOrders(userId)!;
      },
    );
  }

  @override
  Future<Either<Failure, bool>>? registerOrder(
    bool breakfast,
    bool lunch,
    bool dinner,
    int userId,
    String createdAt,
  ) async {
    return _handleNetworkRequest(
      () async {
        return await myOrderDataSource.registerOrder(
            breakfast, lunch, dinner, userId, createdAt)!;
      },
    );
  }

  @override
  Future<Either<Failure, GeneralOrder>>? getGeneralOrder(
      String createdAt) async {
    return _handleNetworkRequest(
      () async {
        return await myOrderDataSource.getGeneralOrder(createdAt)!;
      },
    );
  }
}
