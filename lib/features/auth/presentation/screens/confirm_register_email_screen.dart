import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../home/presentation/providers/providers.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ConfirmRegisterEmailScreen extends ConsumerWidget {
  static const String routeName = 'register_email_screen';
  const ConfirmRegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) async {
          showConnectivitySnackBar(context, connectivityResult);
          if (connectivityResult == ConnectivityResult.none) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
            await ref.read(authNotifierProvider.notifier).checkAuthStatus();
          }
        },
      );
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConfirmRegisterForm(),
          ),
        ),
      ),
    );
  }
}

class ConfirmRegisterForm extends ConsumerWidget {
  const ConfirmRegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ImgAuth(), // Encabezado con imagen
        const SizedBox(height: 20),
        const TitleApp(
          text: 'Confirmar Correo Electrónico',
        ), // Título de la pantalla
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            keyboardType: TextInputType.emailAddress,
          ),
        ), // Campo de entrada de correo
        const SizedBox(height: 30),
        const DescriptionTextAuth(
          description:
              'Hola, en este punto tu información será usada para confirmar tu registro en nuestro sistema, en cuento se confirme tu identidad se te enviará un correo con la contraseña.',
        ), // Descripción debajo del campo
        const SizedBox(height: 40),
        ContentButtonAuth(
          primaryButton: FilledButton(
            onPressed: () {
              // Acción al solicitar registro
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Solicitar Registro'),
          ),
          secondaryButton: const BackButtonAuth(
            textButton: 'Volver',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
