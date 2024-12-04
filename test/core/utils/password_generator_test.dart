import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/core.dart';

void main() {
  group('Password Generator', () {
    test('La contraseña generada tiene entre 7 y 8 caracteres', () {
      final password = generatePassword();
      print(password);
      expect(password.length,
          inInclusiveRange(7, 8)); // Verifica que tenga entre 7 y 8 caracteres
    });

    test('La contraseña generada comienza con una letra mayúscula', () {
      final password = generatePassword();
      print(password);
      expect(
          password[0],
          matches(
              RegExp(r'[A-Z]'))); // Verifica que la primera letra sea mayúscula
    });

    test('La contraseña generada contiene solo letras y números', () {
      final password = generatePassword();
      print(password);
      expect(
          password,
          matches(RegExp(
              r'^[A-Za-z0-9]+$'))); // Verifica que solo contiene letras y números
    });

    test('La contraseña generada contiene al menos un número', () {
      final password = generatePassword();
      print(password);
      expect(password,
          contains(RegExp(r'\d'))); // Verifica que contiene al menos un número
    });

    test('La contraseña generada contiene al menos una letra minúscula', () {
      final password = generatePassword();
      print(password);
      expect(
          password,
          contains(RegExp(
              r'[a-z]'))); // Verifica que contiene al menos una letra minúscula
    });

    test('La contraseña generada contiene al menos una letra mayúscula', () {
      final password = generatePassword();
      print(password);
      expect(
          password,
          contains(RegExp(
              r'[A-Z]'))); // Verifica que contiene al menos una letra mayúscula
    });
  });
}
