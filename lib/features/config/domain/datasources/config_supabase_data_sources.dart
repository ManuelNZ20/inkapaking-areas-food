import '../../data/data.dart';

/// [ConfigDataSources] es una clase abstracta que define las fuentes de datos para la función de configuración.
abstract class ConfigDataSources {
  /// Actualizar datos del usuario
  Future<UserModel>? configUpdateData(
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
  Future<UserModel>? configGetUserById(
    int userId,
  );
}
