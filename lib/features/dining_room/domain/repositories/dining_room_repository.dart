import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../../data/data.dart';
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
}
