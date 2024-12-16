import 'package:formz/formz.dart';

// Define los errores de validación
enum PhoneError { empty, invalid, length }

class InputPhone extends FormzInput<String, PhoneError> {
  // Expresión regular para validar números de teléfono peruanos
  static final RegExp phoneRegExp = RegExp(r'^(9\d{8})$|^(\d{1,2}\d{7})$');

  // Constructor para el valor "puro" (sin modificaciones)
  const InputPhone.pure() : super.pure('');

  // Constructor para el valor "sucio" (modificado)
  const InputPhone.dirty(super.value) : super.dirty();

  // Mensaje de error para mostrar al usuario
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneError.empty) return 'El campo es requerido';
    if (displayError == PhoneError.invalid) {
      return 'Número de teléfono no válido';
    }
    if (displayError == PhoneError.length) {
      return 'El número debe tener 9 dígitos';
    }
    return null;
  }

  // Función de validación
  @override
  PhoneError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneError.empty;

    final trimmedValue = value.trim();

    // Validación de longitud
    if (trimmedValue.length != 9) {
      return PhoneError.length;
    }

    // Validación de formato (con la expresión regular)
    if (!phoneRegExp.hasMatch(trimmedValue)) {
      return PhoneError.invalid;
    }

    return null;
  }
}
