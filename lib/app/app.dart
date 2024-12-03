import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../config/config.dart';
import '../core/core.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) {
          print(connectivityResult);
          if (connectivityResult == ConnectivityResult.none ||
              connectivityResult == ConnectivityResult.wifi) {
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
    return MaterialApp.router(
      title: AppContants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      routerConfig: appRouter,
    );
  }
}
