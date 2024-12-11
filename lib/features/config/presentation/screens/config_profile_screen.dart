import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';

class ConfigProfileScreen extends ConsumerWidget {
  static const String routeName = 'config_profile_screen';
  const ConfigProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configuración de usuario'),
        ),
        body: const _SettingForm(),
      ),
    );
  }
}

class _SettingForm extends ConsumerWidget {
  const _SettingForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.isSigningOut) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            // icon: const Icon(Icons.person),
            child: const Text('Editar datos'),
          ),
          const SizedBox(height: 12),
          // Boton para mostrar notificaciones

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
