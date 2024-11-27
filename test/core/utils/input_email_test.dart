import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/utils/utils.dart';

void main() {
  group(
    'InputEmail',
    () {
      // Test para un correo vacío
      test('should return an error when the email is empty', () {
        const input = InputEmail.dirty('');
        expect(input.errorMessage, 'El campo es requerido');
        expect(input.isValid, false); // El campo no debe ser válido
      });

      // Test para un correo con formato incorrecto
      test('should return an error when the email format is invalid', () {
        const input = InputEmail.dirty('test@example');
        expect(input.errorMessage, 'No tiene formato de correo electrónico');
        expect(input.isValid, false); // El campo no debe ser válido
      });

      // Test para un correo con formato correcto
      test('should be valid when the email has a valid format', () {
        const input = InputEmail.dirty('test@example.com');
        expect(input.errorMessage, isNull); // No debe haber error
        expect(input.isValid, true); // El campo debe ser válido
      });

      // Test para un correo con espacios extra
      test('should return an error when the email has spaces', () {
        const input = InputEmail.dirty('   test@example.com   ');
        expect(input.errorMessage,
            isNull); // No debe haber error, el espacio extra se elimina
        expect(input.isValid, true); // El campo debe ser válido
      });
    },
  );
}
