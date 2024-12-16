import 'package:formz/formz.dart';

// Define los errores de validación
enum NameError { empty, invalid, length }

class InputName extends FormzInput<String, NameError> {
  // Expresión regular para permitir solo letras y espacios
  static final RegExp nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚÑñ\s]+$');

  // Longitudes mínimas y máximas
  static const int minLength = 2;
  static const int maxLength = 50;

  // Constructor para el valor "puro" (sin modificaciones)
  const InputName.pure() : super.pure('');

  // Constructor para el valor "sucio" (modificado)
  const InputName.dirty(super.value) : super.dirty();

  // Mensaje de error para mostrar al usuario
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.invalid) {
      return 'Solo se permiten letras y espacios';
    }
    if (displayError == NameError.length) {
      return 'El nombre debe tener entre $minLength y $maxLength caracteres';
    }
    return null;
  }

  // Función de validación
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;

    final trimmedValue = value.trim();

    // Convertir la primera letra a mayúscula y el resto a minúscula
    final capitalizedValue = _capitalize(trimmedValue);

    // Validación de longitud
    if (capitalizedValue.length < minLength ||
        capitalizedValue.length > maxLength) {
      return NameError.length;
    }

    // Validación de caracteres permitidos
    if (!nameRegExp.hasMatch(capitalizedValue)) {
      return NameError.invalid;
    }

    return null;
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}
