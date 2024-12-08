import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

/// Interfaz para el repositorio de autenticación.
/// Se conecta con la fuente de datos de autenticación para realizar operaciones de autenticación.
abstract class AuthRepository {
  /// Iniciar sesión con correo electrónico y contraseña
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [AuthException] si hay problemas con la autenticación.
  /// - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, User>>? signInWithEmailAndPassword(
    String email,
    String password,
  );

  // Regístrate con correo electrónico y contraseña
  // Puede lanzar las siguientes excepciones:
  // - [NetworkException] si hay problemas de conexión.
  // - [AuthException] si hay problemas con la autenticación.
  // - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, User>>? signUpWithDataUser(
    String name,
    String lastName,
    bool gender,
    String phone,
    String direction,
    bool stateAccount,
    String email,
  );

  /// Sign out
  Future<Either<Failure, User>>? signOut();

  /// Obtener el usuario actual
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [AuthException] si hay problemas con la autenticación.
  /// - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, User>>? getCurrentUser(
    String email,
  );
  // Recover the password by sending a recovery token to the email.
  Future<Either<Failure, bool>>? recoverPassword(
    String email,
  );

  /// Actualizar contraseña
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [AuthException] si hay problemas con la autenticación.
  /// - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, bool>>? updatePassword(
    String email,
    String newPassword,
  );

  /// Enviar correo electrónico de recuperación
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [AuthException] si hay problemas con la autenticación.
  /// - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, bool>>? sendRecoveryEmail(
    String email,
    String newPassword,
  );

  /// Obtener el usuario actual por token
  /// Puede lanzar las siguientes excepciones:
  /// - [NetworkException] si hay problemas de conexión.
  /// - [AuthException] si hay problemas con la autenticación.
  /// - [ServerException] si hay problemas con el servidor.
  Future<Either<Failure, User>>? getCurrentUserByToken(
    int token,
  );
}
