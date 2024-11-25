import 'package:equatable/equatable.dart';

// clase abstracta para manejar los errores de la aplicacion ,sirve para casos de uso y repositorios como una interfaz, ademas de ser una clase abstracta que hereda de Equatable, para poder comparar objetos de manera sencilla, y esta clase Failure tiene una lista de propiedades que se pueden comparar y sirven para manejar los errores de la aplicacion como errores de autenticacion, errores de red, errores de base de datos, etc.
abstract class Failure extends Equatable {
  // definir los errores de la aplicacion para el manejo de errores de autenticacion
  const Failure([List properties = const <dynamic>[]]) : super();
}
