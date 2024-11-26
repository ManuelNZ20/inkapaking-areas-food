import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure([String message = 'Server Failure']) : super([message]);

  @override
  List<Object> get props => [];
}
