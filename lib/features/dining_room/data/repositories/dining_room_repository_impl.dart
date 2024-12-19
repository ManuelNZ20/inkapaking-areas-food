import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class DiningRoomRepositoryImpl extends DiningRoomRepository {
  final DiningRoomRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DiningRoomRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _handleNetworkRequest<T>(
    Future<T> Function() request,
  ) async {
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
      return Left(ServerFailure("No hay conexión a Internet"));
    }
  }

  Stream<Either<Failure, T>> _handleNetworkRequestStream<T>(
    Stream<T> Function() request,
  ) async* {
    if (await networkInfo.isConnected) {
      try {
        final result = request();
        await for (final event in result) {
          yield Right(event);
        }
      } on ServerException catch (e) {
        yield Left(ServerFailure(e.message));
      } on GenericException catch (e) {
        yield Left(CustomFailure(e.toString()));
      }
    } else {
      yield Left(ServerFailure("No hay conexión a Internet"));
    }
  }

  @override
  Future<Either<Failure, Saucer>>? createSaucer(
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String createdAt,
  ) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.createSaucer(
        nameSaucer,
        nameDrink,
        scheduleId,
        createdAt,
      )!;
    });
  }

  @override
  Future<Either<Failure, bool>> deleteSaucer(
    int saucerId,
  ) {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.deleteSaucer(saucerId) ?? false;
    });
  }

  @override
  Future<Either<Failure, List<Saucer>>>? listSaucers() async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.listSaucers()!;
    });
  }

  @override
  Future<Either<Failure, List<Schedule>>>? listSchedules() async {
    return _handleNetworkRequest(
      () async {
        return await remoteDataSource.listSchedules()!;
      },
    );
  }

  @override
  Future<Either<Failure, Saucer>>? updateSaucer(
    int saucerId,
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String updateAt,
  ) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.updateSaucer(
        saucerId,
        nameSaucer,
        nameDrink,
        scheduleId,
        updateAt,
      )!;
    });
  }

  @override
  Future<Either<Failure, Saucer>>? getSaucerById(int saucerId) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.getSaucerById(saucerId)!;
    });
  }

  @override
  Future<Either<Failure, List<Saucer>>>? getSaucersByScheduleId(
    int scheduleId,
    int from,
    int to,
  ) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.getSaucersByScheduleId(
        scheduleId,
        from,
        to,
      )!;
    });
  }

  @override
  Future<Either<Failure, bool>>? addSaucerToGeneralOrder(
      int generalOrderId, List<int> saucerId) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.addSaucerToGeneralOrder(
        generalOrderId,
        saucerId,
      )!;
    });
  }

  @override
  Future<Either<Failure, GeneralOrder>>? createGeneralOrder(
      String startDate, String endDate, String createdAt) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.createGeneralOrder(
        startDate,
        endDate,
        createdAt,
      )!;
    });
  }

  @override
  Future<Either<Failure, List<GeneralOrder>>>? listGeneralOrders() async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.listGeneralOrders()!;
    });
  }

  @override
  Future<Either<Failure, bool>>? getLastGeneralOrder(String createdAt) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.getLastGeneralOrder(createdAt)!;
    });
  }

  @override
  Future<Either<Failure, GeneralOrder>>? getTodayGeneralOrder(
      String date) async {
    return _handleNetworkRequest(() async {
      return await remoteDataSource.getTodayGeneralOrder(date)!;
    });
  }

  @override
  Stream<Either<Failure, GeneralOrder>>? getLastGeneralOrderStream(
      String createdAt) {
    return _handleNetworkRequestStream(
        () => remoteDataSource.getLastGeneralOrderStream(createdAt)!);
  }
}
