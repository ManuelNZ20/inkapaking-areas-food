import '../../data/data.dart';

/// Interfaz para la fuente de datos de autenticación.
/// Conecta con Supabase para realizar las operaciones de autenticación.
abstract class AuthRemoteDataSource {
  /// Inicia sesión con correo electrónico y contraseña.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si las credenciales son incorrectas.
  /// - [NetworkException] si hay problemas de conexión.
  Future<UserModel>? signInWithEmailAndPassword(
    String email,
    String password,
  );

  /// Registra un nuevo usuario con los datos proporcionados.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si el correo ya está en uso.
  /// - [NetworkException] si hay problemas de conexión.
  Future<UserModel>? signUpWithDataUser(
    String name,
    String lastName,
    bool gender,
    String phone,
    String direction,
    bool stateAccount,
    String email,
  );

  /// Recupera la contraseña del usuario.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si el correo no está registrado.
  /// - [NetworkException] si hay problemas de conexión.
  Future<bool>? recoverPassword(
    String email,
  );

  /// Obtiene el usuario actual basado en el correo electrónico.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si el usuario no está autenticado.
  /// - [NetworkException] si hay problemas de conexión.
  Future<UserModel>? getCurrentUser(
    String email,
  );

  /// Cierra la sesión del usuario actual.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si el usuario no está autenticado.
  /// - [NetworkException] si hay problemas de conexión.
  Future<UserModel>? signOut();

  /// Obtiene el usuario actual basado en el token de autenticación.
  ///
  /// Puede lanzar las siguientes excepciones:
  /// - [AuthException] si el usuario no está autenticado.
  /// - [NetworkException] si hay problemas de conexión.
  Future<UserModel>? getCurrentUserByToken(
    int token,
  );
}
