import '../domain.dart';

/// Interfaz para la fuente de datos de Supabase.
/// Conecta con Supabase para realizar las operaciones de Recursos Humanos.
abstract class RRHHSupabaseDataSource {
  /// Obtiene los tipos de usuarios.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Stream<List<TypeUser>>? getTypeUsers();

  /// Crea un nuevo tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUser>? createTypeUser(
    String typeName,
    String description,
  );

  /// Elimina un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUser>? deleteTypeUser(int id);

  /// Actualiza un tipo de usuario.
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [RRHHException] si hay problemas con la base de datos.
  /// - [FormatException] si hay problemas con el formato de los datos.
  Future<TypeUser>? updateTypeUser(
    int id,
    String typeName,
    String description,
  );
}
