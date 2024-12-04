import 'failure.dart';

class EmailSendFailure extends Failure {
  final String message;

  const EmailSendFailure(this.message);

  @override
  List<Object> get props => [message];
}
