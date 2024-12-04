import 'dart:math';

String generatePassword() {
  // Definir los caracteres que se usarán en la generación de la contraseña
  const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const digits = '0123456789';

  // Inicializar el generador de números aleatorios
  final rand = Random.secure();

  // Asegurarse de que la contraseña tenga al menos una mayúscula, minúscula y número
  String password = '';

  // Añadir la primera letra en mayúscula
  password += upperCase[rand.nextInt(upperCase.length)];

  // Asegurarse de que la contraseña tenga al menos un número
  password += digits[rand.nextInt(digits.length)];

  // Completar la contraseña con caracteres aleatorios (letras y números) para que tenga entre 7 y 8 caracteres
  const allChars = lowerCase + upperCase + digits;
  int passwordLength = 7 + rand.nextInt(2); // Generar entre 7 y 8 caracteres

  // Agregar caracteres aleatorios para completar la longitud de la contraseña
  while (password.length < passwordLength) {
    password += allChars[rand.nextInt(allChars.length)];
  }

  // Reordenar la contraseña aleatoriamente para asegurar que los caracteres no estén ordenados
  password = String.fromCharCodes(password.runes.toList()..shuffle(rand));

  return password;
}
