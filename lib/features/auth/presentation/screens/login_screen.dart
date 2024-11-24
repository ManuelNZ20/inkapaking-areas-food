import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
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

class _LoginForm extends StatelessWidget {
  const _LoginForm();

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
            text: 'Bienvenidos a la app de INKAPAKING S.A.C',
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
        const SizedBox(height: 30),
        // Campo de contraseña
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Contraseña',
            hint: 'Ingrese su contraseña',
            obscureText: true,
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        // Enlace de "Olvidaste tu contraseña"
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
            onPressed: () {
              // Acción para iniciar sesión
              context.pushNamed(HomeScreen.routeName);
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
