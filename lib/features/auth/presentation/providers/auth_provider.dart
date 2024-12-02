import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/presentation/providers/login_use_case_provider.dart';
import 'package:inkapaking/features/auth/presentation/providers/state/auth_state.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInWithEmailAndPassword signUpUseCase;

  AuthNotifier({
    required this.signUpUseCase,
  }) : super(AuthState());

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

  void _setLogged(User user) {
    state = state.copyWith(
      user: user,
      status: AuthStatus.authenticated,
      hasUser: true,
      errorMessage: null,
      isSigningIn: false,
      hasFailure: false,
      hasError: false,
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
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(signUpUseCase: ref.read(loginProvider)),
);
