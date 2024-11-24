import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // definir los errores de la aplicacion para el manejo de errores de autenticacion
  const Failure([List properties = const <dynamic>[]]) : super();
}
