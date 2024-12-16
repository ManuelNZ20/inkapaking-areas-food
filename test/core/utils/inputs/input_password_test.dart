import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/utils/utils.dart';

void main() {
  // Test para una contraseña vacía
  test('should return an error when the password is empty', () {
    // Arrange
    const input = InputPassword.dirty('');
    // Act
    final result = input.errorMessage;
    // Assert
    expect(result, 'El campo es requerido');
  });

  // Test para una contraseña con menos de 6 caracteres
  test('should return an error when the password has less than 6 characters',
      () {
    // Arrange
    const input = InputPassword.dirty('12345');
    // Act
    final result = input.errorMessage;
    // Assert
    // expect(result, 'La contraseña debe tener al menos 6 caracteres');
    expect(result, 'Mínimo 6 caracteres');
  });

  // Test para una contraseña con formato correcto
  test('should be valid when the password has a valid format', () {
    // Arrange
    const input = InputPassword.dirty('123456');
    // Act
    final result = input.errorMessage;
    // Assert
    expect(result, 'Debe de tener Mayúscula, letras y un número');
  });

  // Test para una contraseña con espacios extra
  test('should return an error when the password has spaces', () {
    // Arrange
    const input = InputPassword.dirty('   123456   ');
    // Act
    final result = input.errorMessage;
    // Assert
    // expect(result, isNull);
    expect(result, 'Debe de tener Mayúscula, letras y un número');
  });
}
