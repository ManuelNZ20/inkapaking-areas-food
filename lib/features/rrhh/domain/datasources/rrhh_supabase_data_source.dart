import '../../data/data.dart';

/// Interfaz para la fuente de datos de Supabase.
/// Conecta con Supabase para realizar las operaciones de Recursos Humanos.
abstract class RRHHSupabaseDataSource {
  /// Obtiene los tipos de usuarios.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Stream<List<TypeUserModel>>? getTypeUsers();

  /// Crea un nuevo tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUserModel>? createTypeUser(
    String typeName,
    String description,
  );

  /// Elimina un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUserModel>? deleteTypeUser(int id);

  /// Actualiza un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUserModel>? updateTypeUser(
    int id,
    String typeName,
    String description,
  );

  /// Obtener solicitud de nuevo usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoRequestFoundException] si no se encontraron solicitudes.
  Stream<List<RequestUserModel>>? getUserRequests();

  /// Obtener datos un usuario por su id.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoRequestFoundException] si no se encontraron solicitudes.
  /// - [NoDataFoundException] si no se encontraron datos.
  Future<UserModel>? getUserById(int id);

  /// Asignar un nuevo usuario a un área de trabajo.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  /// - [NoUserFoundException] si no se encontraron usuarios.
  /// - [NoAreaFoundException] si no se encontraron áreas.
  Future<UserModel>? assignAreaToUser(int userId, int areaId);
}
