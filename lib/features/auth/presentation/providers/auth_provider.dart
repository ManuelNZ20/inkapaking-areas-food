import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/presentation/providers/login_use_case_provider.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SignInWithEmailAndPassword signUpUseCase;

  AuthNotifier({
    required this.signUpUseCase,
  }) : super(const AsyncValue.loading());

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await signUpUseCase.call(
      SignInWithEmailAndPasswordParams(
        email: email,
        password: password,
      ),
    );
    result.fold(
      // (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (failure) {
        if (failure is AuthenticationFailure) {
          state =
              AsyncValue.error('Credenciales incorrectas', StackTrace.current);
        } else if (failure is ServerFailure) {
          state = AsyncValue.error(
              'Problema con el servidor. Inténtelo más tarde.',
              StackTrace.current);
        } else if (failure is ServerFailure) {
          state =
              AsyncValue.error('Sin conexión a Internet', StackTrace.current);
        } else {
          state = AsyncValue.error('Error desconocido', StackTrace.current);
        }
      },
      _setLogged,
    );
  }

  void _setLogged(User user) async {
    print('Usuario logueado: ${user.email}');
    state = AsyncValue.data(user);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
  (ref) => AuthNotifier(signUpUseCase: ref.read(loginProvider)),
);
