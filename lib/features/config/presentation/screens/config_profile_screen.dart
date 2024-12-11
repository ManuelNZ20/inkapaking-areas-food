import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/presentation/widgets/widgets.dart';
import 'package:inkapaking/features/config/presentation/providers/user_provider.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';

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
          title: Text('Configuración de usuario $userId'),
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Fecha de creación:'),
          const SizedBox(height: 12),
          Text(user.createAt),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Nombre',
            hint: 'Ingrese su nombre',
            initialValue: user.name,
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Apellidos',
            hint: 'Ingrese sus apellidos',
            initialValue: user.lastName,
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Teléfono',
            hint: 'Ingrese su teléfono',
            initialValue: user.phone,
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Dirección',
            hint: 'Ingrese su dirección',
            initialValue: user.direction,
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Correo',
            hint: 'Ingrese su correo',
            initialValue: user.email,
            onChanged: (value) {},
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
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
