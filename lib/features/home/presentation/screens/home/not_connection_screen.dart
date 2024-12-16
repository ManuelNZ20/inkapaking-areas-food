import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/presentation/providers/providers.dart';
import '../../../../../core/core.dart';
import '../../providers/providers.dart';

class NotConnectionScreen extends ConsumerWidget {
  static const routeName = 'home_not_connection';
  const NotConnectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) async {
          showConnectivitySnackBar(context, connectivityResult);
          if (connectivityResult != ConnectivityResult.none) {
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
              onPressed: () async => await ref
                  .read(authNotifierProvider.notifier)
                  .checkAuthStatus(),
            ),
          ],
        ),
      ),
    );
  }
}
