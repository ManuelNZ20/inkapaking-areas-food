import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class InputPassword extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const InputPassword.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const InputPassword.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 6 caracteres';
    if (displayError == PasswordError.format) {
      return 'Debe de tener Mayúscula, letras y un número';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    final trimmedValue = value.trim(); // Eliminar espacios antes y después

    // Si el valor está vacío después de eliminar los espacios
    if (trimmedValue.isEmpty) return PasswordError.empty;
    if (trimmedValue.length < 6) return PasswordError.length;
    if (!passwordRegExp.hasMatch(trimmedValue)) return PasswordError.format;

    return null;
  }
}
