import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/presentation/providers/login_use_case_provider.dart';
import 'package:inkapaking/features/auth/presentation/providers/state/auth_state.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithEmailAndPassword signUpUseCase;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier({
    required this.signUpUseCase,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    // Simular carga
    state = state.copyWith(
      isSigningIn: true,
      hasFailure: false,
      hasError: false,
      errorMessage: null,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await signUpUseCase.call(
      SignInWithEmailAndPasswordParams(
        email: email,
        password: password,
      ),
    );
    result.fold(
      (failure) => _handleFailure(failure),
      _setLogged,
    );
  }

  void _setLogged(User user) async {
    final token = user.tokens!.firstWhere((token) => token.state == true);
    state = state.copyWith(
      user: user,
      status: AuthStatus.authenticated,
      hasUser: true,
      errorMessage: null,
      isSigningIn: false,
      hasFailure: false,
      hasError: false,
      token: token.tokenId.toString(),
    );
    await keyValueStorageService.setKeyValue<int>(
      'token',
      int.parse(state.token!),
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is AuthenticationFailure) {
      _updateStateWithFailure(
        errorMessage: 'Credenciales incorrectas',
        hasConnection: true,
      );
    } else if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Fallo el servidor',
        hasConnection: false,
      );
    } else {
      _updateStateWithFailure(
        errorMessage: 'Error desconocido',
      );
    }
  }

  void _updateStateWithFailure({
    required String errorMessage,
    bool hasConnection = true,
  }) {
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      errorMessage: errorMessage,
      isSigningIn: false,
      hasFailure: true,
      hasConnection: hasConnection,
      hasUser: false,
    );
  }

  /// Verificar si el usuario ya esta autenticado
  /// y cargar los datos del usuario
  /// en caso de que ya este autenticado
  Future<void> checkAuthStatus() async {
    final checkAuthentication =
        await signUpUseCase.checkAuthentication(keyValueStorageService);
    checkAuthentication.fold(
      (failure) {
        if (failure is ServerFailure) {
          state = state.copyWith(
            status: AuthStatus.offline,
            hasUser: false,
          );
          return;
        }
        _handleFailure(failure);
      },
      (user) {
        state = state.copyWith(
          user: user,
          status: AuthStatus.authenticated,
          hasUser: true,
        );
        _setLogged(user);
      },
    );
  }

  Future<void> signOut() async {
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      token: null,
      errorMessage: '',
      hasUser: false,
      isSigningIn: false,
      hasFailure: false,
      isSigningOut: true,
      hasToken: false,
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final signUpUseCase = ref.read(loginProvider);
  final keyValueStorageService = ref.read(keyValueStorageProvider);
  return AuthNotifier(
    signUpUseCase: signUpUseCase,
    keyValueStorageService: keyValueStorageService,
  );
});
