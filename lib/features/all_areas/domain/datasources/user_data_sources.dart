import '../domain.dart';

/// Abstracción de la fuente de datos remota de usuario
///
/// La fuente de datos remota de usuario es la interfaz que define los métodos para obtener los datos de usuario de una fuente de datos remota.
abstract class UserRemoteDataSource {
  /// Obtiene los datos del usuario actual
  ///
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  /// Cualquier otro error provoca un error.
  Future<User> getUser();

  /// Datos de un usuario por su id
  ///
  /// Retorna un [Future] que puede ser completado con un [User] si la operación fue exitosa.
  /// Si la operación falla, se completa con un [Exception].
  /// Cualquier otro error provoca un error.
  Future<User> getUserById(int userId);
}
