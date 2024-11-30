import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

enum AuthStatus {
  unknown, // Estado inicial
  authenticated, // Usuario autenticado
  unauthenticated, // Usuario no autenticado
  verifying, // Verificando autenticación
  checking, // Verificando conexión
}

class AuthState {
  final AuthStatus status; // Estado de autenticación
  final User? user; // Usuario autenticado
  final String? errorMessage; // Mensaje de error
  final bool hasError; // Si hay un error
  final bool hasFailure; // Si hay un fallo
  final bool hasUser; // Si hay un usuario
  final bool hasToken; // Si hay un token
  final bool hasConnection; // Si hay conexión a Internet
  final bool isRecoveringPassword; // Si se está recuperando la contraseña
  final bool isSigningIn; // Si se está iniciando sesión
  final bool isSigningOut; // Si se está cerrando sesión
  final bool isSigningUp; // Si se está registrando
  final bool isVerifying; // Si se está verificando
  final String? token;

  AuthState({
    this.status = AuthStatus.unknown,
    required this.user,
    required this.errorMessage,
    this.hasError = false,
    this.hasFailure = false,
    this.hasUser = false,
    this.hasToken = false,
    this.hasConnection = false,
    this.isRecoveringPassword = false,
    this.isSigningIn = false,
    this.isSigningOut = false,
    this.isSigningUp = false,
    this.isVerifying = false,
    this.token = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    bool? hasError,
    bool? hasFailure,
    bool? hasUser,
    bool? hasToken,
    bool? hasConnection,
    bool? isRecoveringPassword,
    bool? isSigningIn,
    bool? isSigningOut,
    bool? isSigningUp,
    bool? isVerifying,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      hasFailure: hasFailure ?? this.hasFailure,
      hasUser: hasUser ?? this.hasUser,
      hasToken: hasToken ?? this.hasToken,
      hasConnection: hasConnection ?? this.hasConnection,
      isRecoveringPassword: isRecoveringPassword ?? this.isRecoveringPassword,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      isSigningOut: isSigningOut ?? this.isSigningOut,
      isSigningUp: isSigningUp ?? this.isSigningUp,
      isVerifying: isVerifying ?? this.isVerifying,
      token: token ?? this.token,
    );
  }
}
