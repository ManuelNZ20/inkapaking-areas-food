import 'package:inkapaking/core/error/failures/failure.dart';

class EmailFailure extends Failure {
  final String message;
  const EmailFailure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'Fallo de email';
}
