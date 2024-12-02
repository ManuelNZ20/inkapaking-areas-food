import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inkapaking/core/core.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    int count = 0;
    ref.listen<AsyncValue<User?>>(authNotifierProvider, (next, previous) {
      ++count;
      print('$count');
      next!.when(
        data: (data) {
          print('Usuario logueado: ${data!.email}');
          context.push(HomeScreen.routeName);
        },
        error: (error, stackTrace) {
          print('Error: $error');

          String errorMessage = error.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        },
        loading: () {
          print('Cargando...');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cargando...'),
              backgroundColor: Colors.blue,
            ),
          );
        },
      );
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
          child: TitleAuth(
            text: 'Bienvenidos a la app de INKAPAKING S.A.C',
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            errorMessage: loginFormState.isFormPosted
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
            errorMessage: loginFormState.isFormPosted
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
            onPressed: () async {
              ref.read(loginFormProvider.notifier).onFormSubmit();
              final notifier = ref.read(authNotifierProvider.notifier);
              await notifier.signUpWithEmailAndPassword(
                loginFormState.email.value,
                loginFormState.password.value,
              );
            },
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
