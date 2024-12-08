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

  /// Actualiza un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<Either<Failure, TypeUser>>? updateTypeUser(
    int id,
    String typeName,
    String description,
  );
}
