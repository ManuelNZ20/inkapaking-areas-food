import '../../data/data.dart';

/// Esta es una clase abstracta que se utilizará como tipo para que el repositorio obtenga los datos de la fuente remota.
/// La fuente de datos remota es la API de Supabase.
abstract class DiningRoomRemoteDataSource {
  /// Listar platillos de la base de datos.
  /// Este método se encarga de listar todos los platillos de la base de datos.
  /// Retorna una lista de platillos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<SaucerModel>>? listSaucers();

  /// Listar horarios de la base de datos.
  /// Este método se encarga de listar todos los horarios de la base de datos.
  /// Retorna una lista de horarios.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<ScheduleModel>>? listSchedules();

  /// Crear un platillo en la base de datos.
  /// Este método se encarga de crear un platillo en la base de datos.
  /// Retorna el platillo creado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<SaucerModel>? createSaucer(
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String createdAt,
  );

  /// Actualizar un platillo en la base de datos.
  /// Este método se encarga de actualizar un platillo en la base de datos.
  /// Retorna el platillo actualizado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<SaucerModel>? updateSaucer(
    int saucerId,
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String updateAt,
  );

  /// Eliminar un platillo en la base de datos.
  /// Este método se encarga de eliminar un platillo en la base de datos.
  /// Retorna el platillo eliminado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<bool>? deleteSaucer(int saucerId);

  /// Obtener platillo por id de la base de datos.
  /// Este método se encarga de obtener un platillo por id de la base de datos.
  /// Retorna el platillo obtenido.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<SaucerModel>? getSaucerById(int saucerId);

  /// Obtener platillos por id de horario de la base de datos.
  /// Este método se encarga de obtener los platillos por id de horario de la base de datos.
  /// Retorna una lista de platillos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<SaucerModel>>? getSaucersByScheduleId(
    int scheduleId,
    int from,
    int to,
  );

  /// Crear una orden general en la base de datos.
  /// Este método se encarga de crear una orden general en la base de datos.
  /// Retorna la orden general creada.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<GeneralOrderModel>? createGeneralOrder(
    String startDate,
    String endDate,
    String createdAt,
  );

  /// Listar ordenes generales de la base de datos.
  /// Este método se encarga de listar todas las ordenes generales de la base de datos.
  /// Retorna una lista de ordenes generales.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<GeneralOrderModel>>? listGeneralOrders();

  /// Agregar un platillo a una orden general en la base de datos.
  /// Este método se encarga de agregar un platillo a una orden general en la base de datos.
  /// Retorna la orden general con el platillo agregado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  /// Si el platillo ya se encuentra en la orden general, se lanza una excepción como [ResourceAlreadyExistException].
  Future<bool>? addSaucerToGeneralOrder(
    int generalOrderId,
    List<int> saucerId,
  );

  Future<GeneralOrderModel>? getLastGeneralOrder(String createdAt);
}
