class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException([this.message = "Unauthorized access."]);
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(
      [this.message = "You do not have permission to perform this action."]);
}
