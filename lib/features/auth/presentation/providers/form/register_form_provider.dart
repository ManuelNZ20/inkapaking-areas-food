import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(registerProvider);
  return RegisterFormNotifier(
    registerUserCallback: registerUserCallback,
  );
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final SignUpWithDataUser registerUserCallback;
  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  onNameChange(String value) {
    final newName = InputName.dirty(value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName,
        state.lastName,
        state.phone,
      ]),
    );
  }

  onLastNameChange(String value) {
    final newLastName = InputName.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([
        state.name,
        newLastName,
      ]),
    );
  }

  onGenderChange(String value) {
    state = state.copyWith(
      gender: value == 'M',
    );
  }

  onPhoneChange(String value) {
    final newPhone = InputPhone.dirty(value);
    state = state.copyWith(
      phone: newPhone,
      isValid: Formz.validate([
        state.name,
        state.lastName,
        newPhone,
      ]),
    );
  }

  onDirectionChange(String value) {
    state = state.copyWith(
      direction: value,
    );
  }

  onEmailChange(String value) {
    final newEmail = InputEmail.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        state.name,
        state.lastName,
        state.phone,
        newEmail,
      ]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    print(state.isValid);
    if (!state.isValid) return;
    state = state.copyWith(
      isPosting: true,
      hasError: false,
      errorMessage: null,
      isFormPosted: false,
    );
    final result = await registerUserCallback(SignUpWithDataUserParams(
      name: state.name.value,
      lastName: state.lastName.value,
      gender: state.gender,
      phone: state.phone.value,
      direction: state.direction,
      email: state.email.value,
      stateAccount: false,
    ));
    result.fold(
      _handleFailure,
      _handleSuccess,
    );
  }

  void _handleSuccess(User user) {
    print('Usuario registrado');
    state = state.copyWith(
      isFormPosted: true,
      hasError: false,
      errorMessage: null,
      isPosting: false,
    );
  }

  void _handleFailure(Failure failure) {
    print('Usuario registrado');
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
    final name = InputName.dirty(state.name.value);
    final lastName = InputName.dirty(state.lastName.value);
    final phone = InputPhone.dirty(state.phone.value);
    final email = InputEmail.dirty(state.email.value);
    state = state.copyWith(
      isFormPosted: true,
      name: name,
      lastName: lastName,
      phone: phone,
      email: email,
      isValid: Formz.validate([name, lastName, phone, email]),
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final InputName name;
  final InputName lastName;
  final bool gender;
  final InputPhone phone;
  final String direction;
  final InputEmail email;
  final bool hasError;
  final String? errorMessage;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const InputName.pure(),
    this.lastName = const InputName.pure(),
    this.gender = false,
    this.phone = const InputPhone.pure(),
    this.direction = '',
    this.email = const InputEmail.pure(),
    this.hasError = false,
    this.errorMessage = '',
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputName? name,
    InputName? lastName,
    bool? gender,
    InputPhone? phone,
    String? direction,
    InputEmail? email,
    bool? hasError,
    String? errorMessage,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        direction: direction ?? this.direction,
        email: email ?? this.email,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
