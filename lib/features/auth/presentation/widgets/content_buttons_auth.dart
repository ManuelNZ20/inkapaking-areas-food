import 'package:flutter/material.dart';

class ContentButtonAuth extends StatelessWidget {
  const ContentButtonAuth({
    super.key,
    required this.primaryButton,
    required this.secondaryButton,
  });

  final FilledButton primaryButton;
  final Widget secondaryButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Botón "Iniciar Sesión"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: primaryButton,
        ),
        const SizedBox(height: 10),
        // Botón "Solicitar Registro"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: secondaryButton,
        ),
      ],
    );
  }
}
