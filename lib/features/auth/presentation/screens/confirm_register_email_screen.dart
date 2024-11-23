import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ConfirmRegisterEmailScreen extends StatelessWidget {
  static const String routeName = 'register_email_screen';
  const ConfirmRegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context)
              .unfocus(), // Ocultar teclado al hacer tap afuera
          child: const SingleChildScrollView(
            child: ConfirmRegisterForm(),
          ),
        ),
      ),
    );
  }
}

class ConfirmRegisterForm extends StatelessWidget {
  const ConfirmRegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ImgAuth(), // Encabezado con imagen
        SizedBox(height: 20),
        TitleAuth(
          text: 'Confirmar Correo Electrónico',
        ), // Título de la pantalla
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            keyboardType: TextInputType.emailAddress,
          ),
        ), // Campo de entrada de correo
        SizedBox(height: 30),
        DescriptionTextAuth(
          description:
              'Hola, en este punto tu información será usada para confirmar tu registro en nuestro sistema, en cuento se confirme tu identidad se te enviará un correo con la contraseña.',
        ), // Descripción debajo del campo
        SizedBox(height: 40),
        _ActionButtons(), // Botones de acción
        SizedBox(height: 20),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          FilledButton(
            onPressed: () {
              // Acción al solicitar registro
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Solicitar Registro'),
          ),
          const SizedBox(height: 14),
          const BackButtonAuth(
            textButton: 'Volver',
          ),
        ],
      ),
    );
  }
}
