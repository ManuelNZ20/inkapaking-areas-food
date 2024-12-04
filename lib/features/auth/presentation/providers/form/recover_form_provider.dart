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
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);
    final result = await recoverPassword(RecoverPasswordParams(
      email: state.email.value,
    ));
    state = state.copyWith(
      isPosting: false,
      isFormPosted: result.fold(
        (l) => false,
        (r) => true,
      ),
      hasError: result.isLeft(),
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

  // Constructor
  RecoverFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const InputEmail.pure(),
    this.hasError = false,
  });

  RecoverFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputEmail? email,
    bool? hasError,
  }) =>
      RecoverFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        hasError: hasError ?? this.hasError,
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
          ''';
  }
}
