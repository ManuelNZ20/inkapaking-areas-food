import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final recoverFormProvider =
    StateNotifierProvider.autoDispose<RecoverFormNotifier, RecoverFormState>(
        (ref) {
  final recoverPassword = ref.watch(recoverPasswordProvider);
  return RecoverFormNotifier(
    recoverPassword: recoverPassword,
  );
});

class RecoverFormNotifier extends StateNotifier<RecoverFormState> {
  final RecoverPassword recoverPassword;
  RecoverFormNotifier({
    required this.recoverPassword,
  }) : super(RecoverFormState());

  onEmailChange(String value) {
    final newEmail = InputEmail.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail]),
      errorMessage: null,
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(
      isPosting: true,
      hasError: false,
      errorMessage: null,
      isFormPosted: false,
    );
    final result = await recoverPassword(RecoverPasswordParams(
      email: state.email.value,
    ));
    result.fold(
      _handleFailure,
      (r) {
        Future.delayed(const Duration(milliseconds: 800), () {
          state = state.copyWith(
            isPosting: false,
            isFormPosted: true,
            hasError: false,
            errorMessage: null, // Reseteamos cualquier mensaje de error
          );
        });
      },
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
      isPosting: false,
      hasError: true,
      errorMessage: errorMessage,
    );
  }

  _touchEveryField() {
    final email = InputEmail.dirty(state.email.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([email]),
    );
  }
}

class RecoverFormState {
  // Si se está enviando la petición
  final bool isPosting;

  // Si se ha enviado la petición
  final bool isFormPosted;

  // Si el formulario es válido
  final bool isValid;

  // InputEmail del usuario
  final InputEmail email;

  // Si hay un error
  final bool hasError;

  // Mensaje de error
  final String? errorMessage;

  // Constructor
  RecoverFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const InputEmail.pure(),
    this.hasError = false,
    this.errorMessage = '',
  });

  RecoverFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputEmail? email,
    bool? hasError,
    String? errorMessage,
  }) =>
      RecoverFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  String toString() {
    return '''
    RecoverFormState
    isPosting: $isPosting
    isFormPosting: $isFormPosted
    isValid: $isValid
    email: $email
    hasError: $hasError
    errorMessage: $errorMessage
          ''';
  }
}
