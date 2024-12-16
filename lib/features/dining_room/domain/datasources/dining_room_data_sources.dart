import '../domain.dart';

/// Esta es una clase abstracta que se utilizará como tipo para que el repositorio obtenga los datos de la fuente remota.
/// La fuente de datos remota es la API de Supabase.
abstract class DiningRoomRemoteDataSource {
  /// Listar platillos de la base de datos.
  /// Este método se encarga de listar todos los platillos de la base de datos.
  /// Retorna una lista de platillos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<Saucer>> listSaucers();

  /// Listar horarios de la base de datos.
  /// Este método se encarga de listar todos los horarios de la base de datos.
  /// Retorna una lista de horarios.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<List<Schedule>> listSchedules();

  /// Crear un platillo en la base de datos.
  /// Este método se encarga de crear un platillo en la base de datos.
  /// Retorna el platillo creado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Saucer> createSaucer(
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
  Future<Saucer> updateSaucer(
    int saucerId,
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String createdAt,
  );

  /// Eliminar un platillo en la base de datos.
  /// Este método se encarga de eliminar un platillo en la base de datos.
  /// Retorna el platillo eliminado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<bool> deleteSaucer(int saucerId);
}
