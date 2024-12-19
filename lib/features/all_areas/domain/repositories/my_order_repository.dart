import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../dining_room/domain/domain.dart';
import '../domain.dart';

/// Clase abstracta que define los métodos que se deben implementar en el repositorio de pedidos.
abstract class MyOrderRepository {
  /// Método que lista los pedidos de un usuario.
  /// Retorna una lista de pedidos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<Either<Failure, List<MyOrder>>>? listMyOrders(int userId);

  /// Listar los platillos de la orden general del día de la base de datos.
  /// Retorna una lista de platillos de la orden general.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<Either<Failure, List<GeneralOrder>>>? listGeneralOrder(
      String createdAt);

  /// Obtener la orden general del día.
  /// Retorna una orden general.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<Either<Failure, GeneralOrder>>? getGeneralOrder(String createdAt);

  /// Método que permite registrar un pedido.
  /// Retorna un booleano.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si el pedido se registró correctamente, retorna un [true].
  /// Si el pedido no se registró correctamente, retorna un [false].
  Future<Either<Failure, bool>>? registerOrder(
    bool breakfast,
    bool lunch,
    bool dinner,
    int userId,
    String createdAt,
  );
}
