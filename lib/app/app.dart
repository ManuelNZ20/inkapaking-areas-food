import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/config.dart';
import '../core/core.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppContants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      routerConfig: appRouter,
    );
  }
}
