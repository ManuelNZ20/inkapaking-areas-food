import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/widgets.dart';
import '../providers/providers.dart';
import '../providers/utils/utils.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends ConsumerWidget {
  static const String routeName = 'register_screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) async {
          showConnectivitySnackBar(context, connectivityResult);
          await ref.read(authNotifierProvider.notifier).checkAuthStatus();
        },
      );
    });

    final formState = ref.watch(registerFormProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: formState
                    .isPosting // Mostrar loading si se está enviando el formulario
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Enviando solicitud...'),
                    ],
                  )
                : const _RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerFormProvider, (next, previous) {
      if (next!.isPosting && !next.isFormPosted) {
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
    final formState = ref.watch(registerFormProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Imagen en la parte superior
        const _ImageHeader(),
        // Texto de bienvenida
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleApp(
            text: 'Solicitar Registro',
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Nombres',
            hint: 'Ingrese sus nombres',
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).onNameChange(value),
            errorMessage:
                !formState.name.isValid && formState.name.value.isNotEmpty
                    ? formState.name.errorMessage
                    : null,
          ),
        ),
        const SizedBox(height: 25),
        // Contener los radio buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Apellidos',
            hint: 'Ingrese sus apellidos',
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).onLastNameChange(value),
            errorMessage: !formState.lastName.isValid &&
                    formState.lastName.value.isNotEmpty
                ? formState.lastName.errorMessage
                : null,
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SelectedGender(
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).onGenderChange(value),
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Teléfono',
            hint: 'Ingrese su teléfono',
            keyboardType: TextInputType.phone,
            maxLength: 9,
            onChanged: (value) =>
                ref.read(registerFormProvider.notifier).onPhoneChange(value),
            errorMessage:
                !formState.phone.isValid && formState.phone.value.isNotEmpty
                    ? formState.phone.errorMessage
                    : null,
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Dirección',
            hint: 'Ingrese su dirección de residencia',
            onChanged: (value) => ref
                .read(registerFormProvider.notifier)
                .onDirectionChange(value),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo electrónico',
            keyboardType: TextInputType.emailAddress,
            errorMessage:
                !formState.email.isValid && formState.email.value.isNotEmpty
                    ? formState.email.errorMessage
                    : null,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
          ),
        ), // Campo de entrada de correo
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  showInfoDialog(context);
                },
                icon: const Icon(Icons.info),
                label: const Text('Términos y condiciones'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ContentButtonAuth(
          primaryButton: FilledButton(
            onPressed: !formState.isValid
                ? null
                : () async {
                    ref.read(registerFormProvider.notifier).onFormSubmit();
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
