import 'failures.dart';

/// Error genérico para problemas de conexión.
class ConnectionFailure extends Failure {
  ConnectionFailure([String message = "No internet connection"])
      : super([message]);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
