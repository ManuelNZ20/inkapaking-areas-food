import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/presentation/widgets/widgets.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../../home/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class ConfigProfileScreen extends ConsumerWidget {
  static const String routeName = 'config_profile_screen';
  const ConfigProfileScreen({
    super.key,
    required this.userId,
  });
  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      connectivityProvider,
      (previous, next) async {
        next.whenData(
          (connectivityResult) async {
            showConnectivitySnackBar(context, connectivityResult);
            await ref.read(authNotifierProvider.notifier).checkAuthStatus();
          },
        );
      },
    );
    final user = ref.watch(userProvider(userId));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configuración de usuario'),
        ),
        body: user.isLoading
            ? const LoadingViewNotifications()
            : SafeArea(
                child: SingleChildScrollView(
                    child: _SettingForm(user: user.user!)),
              ),
      ),
    );
  }
}

class _SettingForm extends ConsumerWidget {
  const _SettingForm({
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configProfile = ref.watch(configProfileFormProvider(user));
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.isSigningOut) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      }
    });
    final titleScreen = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        );
    final title = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Theme.of(context).colorScheme.primary,
        );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Fecha de creación:',
            style: title,
          ),
          const SizedBox(height: 3),
          Text(
            user.createAt,
            style: titleScreen,
          ),
          const SizedBox(height: 3),
          Text(
            'Tipo de Usuario:',
            style: title,
          ),
          const SizedBox(height: 3),
          Text(
            user.typeName,
            style: titleScreen,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Nombre',
            hint: 'Ingrese su nombre',
            keyboardType: TextInputType.name,
            initialValue: configProfile.name.value,
            errorMessage: !configProfile.name.isValid &&
                    configProfile.name.value.isNotEmpty
                ? configProfile.name.errorMessage
                : null,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onNameChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Apellidos',
            hint: 'Ingrese sus apellidos',
            initialValue: configProfile.lastName.value,
            keyboardType: TextInputType.name,
            errorMessage: !configProfile.lastName.isValid &&
                    configProfile.lastName.value.isNotEmpty
                ? configProfile.lastName.errorMessage
                : null,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onLastNameChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Teléfono',
            hint: 'Ingrese su teléfono',
            initialValue: configProfile.phone.value,
            keyboardType: TextInputType.phone,
            errorMessage: !configProfile.phone.isValid &&
                    configProfile.phone.value.isNotEmpty
                ? configProfile.phone.errorMessage
                : null,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onPhoneChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Dirección',
            hint: 'Ingrese su dirección',
            initialValue: configProfile.direction,
            keyboardType: TextInputType.streetAddress,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onDirectionChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo',
            initialValue: configProfile.email.value,
            keyboardType: TextInputType.emailAddress,
            errorMessage: !configProfile.email.isValid &&
                    configProfile.email.value.isNotEmpty
                ? configProfile.email.errorMessage
                : null,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onEmailChanged,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Contraseña',
            hint: 'Ingrese su contraseña',
            initialValue: configProfile.password.value,
            obscureText: configProfile.obscureText,
            keyboardType: TextInputType.visiblePassword,
            onPressed: ref
                .read(configProfileFormProvider(user).notifier)
                .onViewPassword,
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onPasswordChanged,
          ),
          const SizedBox(height: 12),
          SelectedGender(
            onChanged: ref
                .read(configProfileFormProvider(user).notifier)
                .onGenderChanged,
            initValue: configProfile.gender ? 'M' : 'F',
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => ref
                .read(configProfileFormProvider(user).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Datos actualizado'),
                ),
              );
            }).onError(
              (error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.toString()),
                  ),
                );
              },
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const Icon(Icons.person),
            label: const Text('Editar'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: ref.read(authNotifierProvider).hasConnection
                ? ref.read(authNotifierProvider.notifier).signOut
                : null,
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Salir'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            )
                .copyWith(
                  backgroundColor: const MaterialStatePropertyAll(Colors.red),
                )
                .copyWith(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onPrimary),
                ),
          ),
        ],
      ),
    );
  }
}
