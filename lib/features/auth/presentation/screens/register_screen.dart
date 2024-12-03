import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class RegisterScreen extends ConsumerWidget {
  static const String routeName = 'register_screen';
  const RegisterScreen({super.key});

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
            child: _RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Imagen en la parte superior
        const _ImageHeader(),
        // Texto de bienvenida
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleAuth(
            text: 'Solicitar Registro',
          ),
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Nombres',
            hint: 'Ingrese sus nombres',
          ),
        ),
        const SizedBox(height: 25),
        // Contener los radio buttons
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Apellidos',
            hint: 'Ingrese sus apellidos',
          ),
        ),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child:
              SelectedGender(), //TODO: ADAPTAR A EL USO DE RADIO BUTTONS IMPLEMENTANDO Riverpod
        ),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Teléfono',
            hint: 'Ingrese su teléfono',
            keyboardType: TextInputType.phone,
          ),
        ),
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Dirección',
            hint: 'Ingrese su dirección de residencia',
          ),
        ),
        const SizedBox(height: 25),
        // Colocar los botones al final y se ajusten al tamaño de cualquier pantalla
        SizedBox(height: MediaQuery.of(context).size.height * .1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: OutlinedButton(
            onPressed: () =>
                context.pushNamed(ConfirmRegisterEmailScreen.routeName),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Continuar'),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _ImageHeader extends StatelessWidget {
  const _ImageHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              height: 135,
              AppContants.imgBackgroundRegister, // Cambiar según tu imagen
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: FilledButton.icon(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              label: const Text('Volver'),
            ),
          )
        ],
      ),
    );
  }
}
