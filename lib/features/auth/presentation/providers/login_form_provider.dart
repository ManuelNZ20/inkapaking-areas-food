import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:inkapaking/features/auth/presentation/providers/auth_provider.dart';
import '../../../../core/utils/utils.dart';

// 3 - Como vamos a construir ese provider - StateNotifierProvider - Como se consume afuera
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback =
      ref.watch(authNotifierProvider.notifier).signUpWithEmailAndPassword;
  return LoginFormNotifier(
    loginUserCallback: loginUserCallback,
  );
});

// 2 - Como implementar el notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  LoginFormNotifier({
    required this.loginUserCallback,
  }) : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = InputEmail.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = InputPassword.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  onViewPassword() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);
    await loginUserCallback(state.email.value, state.password.value);
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = InputEmail.dirty(state.email.value);
    final password = InputPassword.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

class LoginFormState {
  final bool isPosting; // Si se está enviando la petición
  final bool isFormPosted; // Si se ha enviado la petición
  final bool isValid; // Si el formulario es válido
  final InputEmail email; // InputEmail del usuario
  final InputPassword password; // Contraseña del usuario
  final bool obscureText; // Si la contraseña es visible

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const InputEmail.pure(),
    this.password = const InputPassword.pure(),
    this.obscureText = true,
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputEmail? email,
    InputPassword? password,
    bool? obscureText,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        obscureText: obscureText ?? this.obscureText,
      );

  @override
  String toString() {
    return '''
    LoginFormState
    isPosting: $isPosting
    isFormPosting: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
          ''';
  }
}
