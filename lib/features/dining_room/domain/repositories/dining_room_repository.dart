import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

/// Abstracción del repositorio del comedor
/// Esta clase es una abstracción del Repositorio del Comedor
/// Se utiliza para definir los métodos que debe implementar la capa de datos de la característica del comedor.
/// La capa de datos será la encargada de implementar estos métodos para interactuar con la fuente de datos (API, Base de Datos, etc)
abstract class DiningRoomRepository {
  /// Listar platillos de la base de datos.
  /// Este método se encarga de listar todos los platillos de la base de datos.
  /// Retorna una lista de platillos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, List<Saucer>>>? listSaucers();

  /// Listar horarios de la base de datos.
  /// Este método se encarga de listar todos los horarios de la base de datos.
  /// Retorna una lista de horarios.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, List<Schedule>>>? listSchedules();

  /// Crear un platillo en la base de datos.
  /// Este método se encarga de crear un platillo en la base de datos.
  /// Retorna el platillo creado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, Saucer>>? createSaucer(
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
  Future<Either<Failure, Saucer>>? updateSaucer(
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
  Future<Either<Failure, bool>>? deleteSaucer(int saucerId);

  /// Obtener platillo por id de la base de datos.
  /// Este método se encarga de obtener un platillo por id de la base de datos.
  /// Retorna el platillo obtenido.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, Saucer>>? getSaucerById(int saucerId);

  /// Obtener platillos por id de horario de la base de datos.
  /// Este método se encarga de obtener los platillos por id de horario de la base de datos.
  /// Retorna una lista de platillos.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, List<Saucer>>>? getSaucersByScheduleId(
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
  Future<Either<Failure, GeneralOrder>>? createGeneralOrder(
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
  Future<Either<Failure, List<GeneralOrder>>>? listGeneralOrders();

  /// Agregar un platillo a una orden general en la base de datos.
  /// Este método se encarga de agregar un platillo a una orden general en la base de datos.
  /// Retorna la orden general con el platillo agregado.
  /// Si ocurre un error, se lanza una excepción como [ServerException].
  /// Si no hay conexión a internet, se lanza una excepción como [NoInternetException].
  /// Si no se encuentra el recurso, se lanza una excepción como [ResourceNotFoundException].
  Future<Either<Failure, GeneralOrder>>? addSaucerToGeneralOrder(
    int generalOrderId,
    int saucerId,
  );
}
