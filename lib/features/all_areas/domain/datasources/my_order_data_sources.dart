import '../../../../core/core.dart';
import '../../../dining_room/data/data.dart';
import '../../data/data.dart';

/// Clase abstracta que define los métodos que se deben implementar en el repositorio de pedidos.
abstract class MyOrderDataSource {
  /// Método que lista los pedidos de un usuario.
  /// Retorna una lista de pedidos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<List<MyOrderModel>>? listMyOrders(int userId);

  /// Listar los platillos de la orden general del día de la base de datos.
  /// Retorna una lista de platillos de la orden general.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<List<GeneralOrderModel>>? listGeneralOrder(String createdAt);

  /// Obtener la orden general del día.
  /// Retorna una orden general.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  Future<GeneralOrderModel>? getGeneralOrder(String createdAt);

  /// Método que permite registrar un pedido.
  /// Retorna un booleano.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si el pedido se registró correctamente, retorna un [true].
  /// Si el pedido no se registró correctamente, retorna un [false].
  Future<bool>? registerOrder(
    bool breakfast,
    bool lunch,
    bool dinner,
    int userId,
    String createdAt,
  );
}
