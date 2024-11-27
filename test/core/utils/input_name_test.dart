import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/utils/input_name.dart';

void main() {
  // Test para un nombre vacío
  test('should return an error when the name is empty', () {
    const input = InputName.dirty('');
    expect(input.errorMessage, 'El campo es requerido');
  });

  // Test para un nombre con caracteres no permitidos
  test('should return an error when the name contains invalid characters', () {
    const input = InputName.dirty('Best123');
    expect(input.errorMessage, 'Solo se permiten letras y espacios');
  });

  // Test para un nombre con longitud insuficiente
  test('should return an error when the name has less than the minimum length',
      () {
    const input = InputName.dirty('M');
    expect(input.errorMessage, 'El nombre debe tener entre 2 y 50 caracteres');
  });

  // Test para un nombre con formato correcto
  test('should be valid when the name or last name has a valid format', () {
    const input = InputName.dirty('Navarro');
    expect(input.errorMessage, isNull);
  });

  // Test para un apellido con espacios extra
  test('should be valid when the last name has leading or trailing spaces', () {
    const input = InputName.dirty('   Pérez   ');
    expect(input.errorMessage, isNull); // No debe haber error
  });
  // Test para la longitud máxima (Supera el límite)
  test('should return an error when the name exceeds the maximum length', () {
    const input = InputName.dirty(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
    expect(input.errorMessage, 'El nombre debe tener entre 2 y 50 caracteres');
  });
  // Test de longitud minima (No llega al mínimo)
  test('should return an error when the name has less than the minimum length',
      () {
    const input = InputName.dirty('M');
    expect(input.errorMessage, 'El nombre debe tener entre 2 y 50 caracteres');
  });
  // Test de nombre con caracteres acentuados y especiales
  test('should be valid when the name contains accented characters or ñ', () {
    const input = InputName.dirty('José María Ñúñez');
    expect(input.errorMessage, isNull); // No debe haber error
  });
  // Test de nombre con espacio interno válido
  test('should be valid when the name contains spaces between words', () {
    const input = InputName.dirty('Walter Navarro');
    expect(input.errorMessage, isNull); // No debe haber error
    expect(input.value, 'Walter Navarro'); // El valor debe ser "Juan carlos"
  });
  // Test de nombre con solo espacios
  test('should return an error when the name contains only spaces', () {
    const input = InputName.dirty('   ');
    expect(input.errorMessage, 'El campo es requerido');
  });
  // Test de nombre con caracteres no permitidos
  test('should return an error when the name contains invalid characters', () {
    const input =
        InputName.dirty('Juan@Pérez'); // Contiene el carácter especial '@'
    expect(input.errorMessage, 'Solo se permiten letras y espacios');
  });
  // Test de nombre con mayúsculas y minúsculas mezcladas
  test('should return an error when the name is not capitalized correctly', () {
    const input = InputName.dirty('juAN AjA');
    expect(input.errorMessage, isNull); // No debe haber error
  });
}
