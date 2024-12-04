import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../widgets/widgets.dart';

class RecoverPasswordScreen extends ConsumerWidget {
  static const String routeName = 'recover_password_screen';
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) {
          if (connectivityResult == ConnectivityResult.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sin conexión a internet")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Conexión restaurada")),
            );
          }
        },
      );
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: _RecoverPasswordForm(),
          ),
        ),
      ),
    );
  }
}

class _RecoverPasswordForm extends StatelessWidget {
  const _RecoverPasswordForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Imagen en la parte superior
        const ImgAuth(),
        const SizedBox(height: 20),
        // Texto de bienvenida
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleAuth(
            text: 'Olvidaste tu contraseña',
          ),
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
          ),
        ),
        const SizedBox(height: 35),
        const DescriptionTextAuth(
          description:
              'Proporcionanos tu correo electrónico, para enviarte una nueva contraseña.',
        ),
        const SizedBox(height: 30),
        ContentButtonAuth(
          primaryButton: FilledButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Enviar'),
          ),
          secondaryButton: const BackButtonAuth(textButton: 'Volver'),
        ),

        const SizedBox(height: 25),
      ],
    );
  }
}
