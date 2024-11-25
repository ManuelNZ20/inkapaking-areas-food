class GenericException implements Exception {
  final String message;
  GenericException([this.message = "An unknown error occurred."]);
}

class InvalidDataException implements Exception {
  final String message;
  InvalidDataException([this.message = "Invalid data encountered."]);
}
