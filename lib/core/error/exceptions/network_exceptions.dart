class NoInternetException implements Exception {
  final String message;
  NoInternetException([this.message = "No internet connection available."]);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException([this.message = "The connection has timed out."]);
}
