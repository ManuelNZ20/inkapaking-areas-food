// Crea documentacion de esta excepcion
/// Exception thrown when the user is not authenticated.
/// Sirve para manejar errores de autenticacion
/// Como por ejemplo cuando el usuario no esta autenticado
class UnauthorizedException implements Exception {
  /// The error message.
  /// Mensaje de error
  final String message;

  /// Creates an instance of [UnauthorizedException].
  UnauthorizedException([this.message = "Unauthorized access."]);
}

/// Exception thrown when the server returns an error.
/// Sirve para manejar errores del servidor como por ejemplo cuando el servidor no responde
/// o cuando hay un error en la base de datos
class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(
      [this.message = "You do not have permission to perform this action."]);
}
