// features/home/helpers/home_listeners.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/core.dart';
import '../../../../features/auth/presentation/providers/providers.dart';
import '../../../../features/rrhh/presentation/providers/providers.dart';
import '../providers/providers.dart';

void setupHomeListeners(
  BuildContext context,
  WidgetRef ref,
  AuthState authState, //authNotifier
) {
  ref.listen(
    userNotificationProvider,
    (previous, next) {
      if (authState.hasUser && authState.user!.typeUser.id == 5) {
        // Usuario RRHH
        next.checkNewRequestUser();
      }
    },
  );

  ref.listen(connectivityProvider, (previous, next) async {
    next.whenData((connectivityResult) async {
      await handleConnectivity(context, ref, connectivityResult);
    });
  });
}
