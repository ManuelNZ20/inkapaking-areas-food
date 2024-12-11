import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

abstract class ConfigRepository {
  /// Actualizar datos del usuario
  Future<Either<Failure, User>>? configUpdateData(
    int userId,
    String email,
    String name,
    String lastName,
    bool gender,
    String phone,
    String direction,
    String password,
  );

  /// Obtener datos de usuario por su id.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoDataFoundException] si no se encontraron datos.
  /// - [NoDataFoundException] si no se encontraron datos.
  Future<Either<Failure, User>>? configGetUserById(
    int userId,
  );
}
