import 'failures.dart';

/// Error personalizado con un código opcional.
class CustomFailure extends Failure {
  final int? code;

  CustomFailure(String message, {this.code}) : super([message]);

  @override
  List<Object> get props => [code ?? -1];
}
