import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';

class ConfigProfileScreen extends ConsumerWidget {
  static const String routeName = 'config_profile_screen';
  const ConfigProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider);
    if (user.status == AuthStatus.offline) {
      return const Center(
        child: Text('Usuario desconectado'),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(authNotifierProvider.notifier).checkAuthStatus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configuracion de usuario'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.person),
                label: const Text('Editar datos'),
              ),
              IconButton(
                onPressed: ref.read(authNotifierProvider).hasConnection
                    ? ref.read(authNotifierProvider.notifier).signOut
                    : null,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
