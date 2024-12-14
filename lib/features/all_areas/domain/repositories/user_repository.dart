import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';

import '../domain.dart';

/// UserRepository
/// Clase abstracta que define los métodos que se deben implementar en el UserRepository
abstract class UserRepository {
  /// Obtiene los datos del usuario actual
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  /// Cualquier otro error provoca un error.
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  Future<Either<Failure, User>> getUser();

  /// Datos de un usuario por su id
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  /// Cualquier otro error provoca un error.
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  Future<Either<Failure, User>> getUserById(int id);
}
