import '../../../domain/domain.dart';

enum AuthStatus {
  /// Estado inicial
  unknown,

  /// Usuario autenticado
  authenticated,

  /// Usuario no autenticado
  unauthenticated,

  /// Verificando autenticación
  verifying,

  /// Verificando conexión
  checking,

  /// Recuperando contraseña
  recovering,

  /// Sin conexión
  /// a Internet
  offline,
}

class AuthState {
  /// Estado de autenticación
  final AuthStatus status;

  /// Usuario autenticado
  final User? user;

  /// Mensaje de error
  final String? errorMessage;

  /// Si hay un error
  final bool hasError;

  /// Si hay un fallo
  final bool hasFailure;

  /// Si hay un usuario
  final bool hasUser;

  /// Si hay un token
  final bool hasToken;

  /// Si hay conexión a Internet
  final bool hasConnection;

  /// Si se está recuperando la contraseña
  final bool isRecoveringPassword;

  /// Si se está iniciando sesión
  final bool isSigningIn;

  /// Si se está cerrando sesión
  final bool isSigningOut;

  /// Si se está registrando
  final bool isSigningUp;

  /// Si se está verificando
  final bool isVerifying;

  /// Token de autenticación
  final String? token;

  AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
    this.hasError = false,
    this.hasFailure = false,
    this.hasUser = false,
    this.hasToken = false,
    this.hasConnection = true,
    this.isRecoveringPassword = false,
    this.isSigningIn = false,
    this.isSigningOut = false,
    this.isSigningUp = false,
    this.isVerifying = false,
    this.token = '',
  });

  AuthState copyWith({
    /// Estado de autenticación
    AuthStatus? status,

    /// Usuario autenticado
    User? user,

    /// Mensaje de error
    String? errorMessage,

    /// Si hay un error
    bool? hasError,

    /// Si hay un fallo
    bool? hasFailure,

    /// Si hay un usuario
    bool? hasUser,

    /// Si hay un token
    bool? hasToken,

    /// Si hay conexión a Internet
    bool? hasConnection,

    /// Si se está recuperando la contraseña
    bool? isRecoveringPassword,

    /// Si se está iniciando sesión
    bool? isSigningIn,

    /// Si se está cerrando sesión
    bool? isSigningOut,

    /// Si se está registrando
    bool? isSigningUp,

    /// Si se está verificando
    bool? isVerifying,

    /// Token de autenticación
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
