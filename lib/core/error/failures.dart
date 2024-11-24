import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // definir los errores de la aplicacion para el manejo de errores de autenticacion
  final List properties;
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}
