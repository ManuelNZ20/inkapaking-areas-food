import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

/// Interfaz para el repositorio de Recursos Humanos.
/// Conecta con la fuente de datos de Supabase para realizar las operaciones de Recursos Humanos.
abstract class RRHHRepository {
  /// Obtiene los tipos de usuarios.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Stream<Either<Failure, List<TypeUser>>>? getTypeUsers();

  /// Obtener el tipo de usuario
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<Either<Failure, User>>? getDetailUserWithTypeUser(int typeId);

  /// Crea un nuevo tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<Either<Failure, TypeUser>>? createTypeUser(
    String typeName,
    String description,
  );

  /// Elimina un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<Either<Failure, TypeUser>>? deleteTypeUser(int id);

  /// Obtener solicitud de nuevo usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoRequestFoundException] si no se encontraron solicitudes.
  Stream<Either<Failure, List<RequestUser>>>? getUserRequests();

  /// Obtener datos un usuario por su id.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoRequestFoundException] si no se encontraron solicitudes.
  /// - [NoDataFoundException] si no se encontraron datos.
  /// - [NoDataFoundException] si no se encontraron datos.
  Future<Either<Failure, User>>? getUserById(int id);

  /// Asignar un área a un usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoRequestFoundException] si no se encontraron solicitudes.
  /// - [NoDataFoundException] si no se encontraron datos.
  Future<Either<Failure, User>>? assignAreaToUser(int userId, int areaId);

  /// Obtener lista de usuarios de solicitudes aceptadas.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<Either<Failure, List<RequestUser>>>? getAcceptedRequests();
}
