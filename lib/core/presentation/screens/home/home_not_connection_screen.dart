import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core.dart';

class HomeNotConnectionScreen extends ConsumerWidget {
  static const routeName = '/home_not_connection';
  const HomeNotConnectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityState = ref.watch(connectivityProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('No hay conexión a internet'),
            ElevatedButton(
              child: const Text('Reintentar'),
              onPressed: () => checkConnectivity(context),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkConnectivity(BuildContext context) async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.none)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Aún sin conexión a internet")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Conexión restaurada")),
    );
  }
}
