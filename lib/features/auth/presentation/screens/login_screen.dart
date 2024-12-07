import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

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
            child: _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (next, previous) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      if (next!.isSigningIn) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      } else if (next.isSigningIn && next.hasFailure) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: const Text('Error del servidor'),
              content:
                  Text(next.errorMessage ?? 'Ocurrió un error desconocido'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    });
    final loginFormState = ref.watch(loginFormProvider);

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
            text: 'Bienvenidos a la app de INKAPAKING S.A.C',
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            errorMessage:
                !loginFormState.isValid && loginFormState.email.value.isNotEmpty
                    ? loginFormState.email.errorMessage
                    : null,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              ref.read(loginFormProvider.notifier).onEmailChange(value);
            },
          ),
        ),
        const SizedBox(height: 30),
        // Campo de contraseña
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Contraseña',
            hint: 'Ingrese su contraseña',
            keyboardType: TextInputType.visiblePassword,
            obscureText: loginFormState.obscureText,
            onPressed: ref.read(loginFormProvider.notifier).onViewPassword,
            errorMessage: !loginFormState.isValid &&
                    loginFormState.password.value.isNotEmpty
                ? loginFormState.password.errorMessage
                : null,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    context.pushNamed(RecoverPasswordScreen.routeName),
                child: const Text(
                  'Olvidaste tu contraseña',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        // Colocar los botones al final y se ajusten al tamaño de cualquier pantalla
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ContentButtonAuth(
          primaryButton: FilledButton(
            onPressed: !loginFormState.isPosting && loginFormState.isValid
                ? () async {
                    ref.read(loginFormProvider.notifier).onFormSubmit();
                    final notifier = ref.read(authNotifierProvider.notifier);
                    await notifier.signUpWithEmailAndPassword(
                      loginFormState.email.value,
                      loginFormState.password.value,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Iniciar Sesión'),
          ),
          secondaryButton: OutlinedButton(
            onPressed: () => context.pushNamed(RegisterScreen.routeName),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Solicitar Registro'),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
