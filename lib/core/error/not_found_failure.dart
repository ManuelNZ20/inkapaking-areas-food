import 'failures.dart';

/// Error para datos no encontrados.
class NotFoundFailure extends Failure {
  NotFoundFailure([String message = "Resource not found"]) : super([message]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
