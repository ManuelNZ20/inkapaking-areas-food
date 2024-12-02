import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/providers.dart';

/// Notificador para manejar el estado de autenticación y redirigir al usuario a la pantalla correcta
final goRouterProvider = Provider((ref) {
  final authNotifier = ref.watch(authNotifierProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

/// Notificador para manejar el estado de autenticación y redirigir al usuario a la pantalla correcta
/// dependiendo de su estado de autenticación.
class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;
  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.status;
    });
  }

  /// Estado de autenticación actual.
  AuthStatus get authStatus => _authStatus;

  /// Actualiza el estado de autenticación y notifica a los oyentes.
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
