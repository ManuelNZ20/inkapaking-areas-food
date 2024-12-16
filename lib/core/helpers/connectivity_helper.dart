import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/providers.dart';

import '../utils/utils.dart';

Future<void> handleConnectivity(
  BuildContext context,
  WidgetRef ref,
  ConnectivityResult connectivityResult,
) async {
  showConnectivitySnackBar(context, connectivityResult);

  if (connectivityResult == ConnectivityResult.none) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await ref.read(authNotifierProvider.notifier).checkAuthStatus();
  }
}
