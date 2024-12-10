import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class RRHHRepositoryImpl implements RRHHRepository {
  final RRHHSupabaseDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RRHHRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
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
      return Left(ServerFailure("No hay conexión a Internet"));
    }
  }

  Stream<Either<Failure, T>> _handleNetworkRequestStream<T>(
      Stream<T> Function() request) async* {
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
  Future<Either<Failure, TypeUser>>? createTypeUser(
      String typeName, String description) {
    // TODO: implement createTypeUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TypeUser>>? deleteTypeUser(int id) {
    // TODO: implement deleteTypeUser
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<TypeUser>>>? getTypeUsers() async* {
    yield* _handleNetworkRequestStream(() => remoteDataSource.getTypeUsers()!);
  }

  @override
  Future<Either<Failure, TypeUser>>? updateTypeUser(
      int id, String typeName, String description) {
    // TODO: implement updateTypeUser
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<RequestUser>>>? getUserRequests() {
    return _handleNetworkRequestStream(
        () => remoteDataSource.getUserRequests()!);
  }

  @override
  Future<Either<Failure, User>>? getUserById(int id) {
    return _handleNetworkRequest(() => remoteDataSource.getUserById(id)!);
  }

  @override
  Future<Either<Failure, User>>? assignAreaToUser(
      int userId, int areaId) async {
    return _handleNetworkRequest(
        () => remoteDataSource.assignAreaToUser(userId, areaId)!);
  }
}
