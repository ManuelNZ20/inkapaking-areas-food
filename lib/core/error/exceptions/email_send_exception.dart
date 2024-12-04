class EmailSendException implements Exception {
  final String message;

  EmailSendException([this.message = "Error al enviar el correo."]);

  @override
  String toString() => message;
}
