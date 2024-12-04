import 'failure.dart';

/// Error genérico para problemas de conexión.
class ConnectionFailure extends Failure {
  ConnectionFailure([String message = "No internet connection"])
      : super([message]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
