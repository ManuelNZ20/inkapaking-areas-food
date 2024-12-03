import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/presentation/providers/providers.dart';
import '../../../core.dart';

class NotConnectionScreen extends ConsumerWidget {
  static const routeName = 'home_not_connection';
  const NotConnectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) async {
          print('Connection $connectivityResult');
          if (connectivityResult == ConnectivityResult.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red[300],
                    ),
                    const Text("Sin conexión a internet"),
                  ],
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Text("Conexión restaurada"),
                  ],
                ),
              ),
            );
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No hay conexión a internet'),
            ElevatedButton(
              child: const Text('Reintentar'),
              onPressed: () => _handleRetry(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRetry(BuildContext context, WidgetRef ref) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Text("Conexión restaurada"),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red[300],
              ),
              const Text("Sin conexión a internet"),
            ],
          ),
        ),
      );
    }
    await ref.read(authNotifierProvider.notifier).checkAuthStatus();
  }
}
