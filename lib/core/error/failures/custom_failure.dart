import 'failure.dart';

/// Error personalizado con un código opcional.
class CustomFailure extends Failure {
  final int? code;

  CustomFailure(String message, {this.code}) : super([message]);

  @override
  List<Object> get props => [code ?? -1];

  @override
  String toString() => 'Error inesperado: $code';
}
