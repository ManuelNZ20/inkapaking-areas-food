import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../home/presentation/providers/providers.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class RecoverPasswordScreen extends ConsumerWidget {
  static const String routeName = 'recover_password_screen';
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData((connectivityResult) async {
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
      });
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

class _RecoverPasswordForm extends ConsumerWidget {
  const _RecoverPasswordForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(recoverFormProvider, (next, previous) {
      if (next!.hasError && next.isPosting && !next.isFormPosted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enviando correo...')),
        );
      } else {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.errorMessage ?? 'Error desconocido')),
          );
        } else if (next.isFormPosted && !next.isPosting) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Correo enviado")),
          );
        }
      }
    });
    final recoverFormState = ref.watch(recoverFormProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Imagen en la parte superior
        const ImgAuth(),
        const SizedBox(height: 20),
        // Texto de bienvenida
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleApp(
            text: 'Olvidaste tu contraseña',
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            errorMessage: !recoverFormState.email.isValid &&
                    recoverFormState.email.value.isNotEmpty
                ? 'Correo electrónico no válido'
                : null,
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(recoverFormProvider.notifier).onEmailChange,
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
            onPressed: !recoverFormState.isValid
                ? null
                : () async {
                    ref.read(recoverFormProvider.notifier).onFormSubmit();
                  },
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
