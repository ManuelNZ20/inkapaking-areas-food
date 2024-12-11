import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/config.dart';
import '../core/core.dart';
import '../features/auth/presentation/providers/providers.dart';
import '../features/rrhh/presentation/providers/providers.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchar las notificaciones de la app
    // authNotifierProvider
    final authNotifier = ref.watch(authNotifierProvider);

    ref.listen(
      userNotifierProvider,
      (previous, next) {
        if (authNotifier.hasUser) {
          if (next.isFirstLoad) {
            next.checkNewRequestUser();
          }
          if (authNotifier.user!.typeUser.id == 5) {
            next.checkNewRequestUser();
          }
        }
      },
    );

    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppContants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      routerConfig: appRouter,
    );
  }
}
