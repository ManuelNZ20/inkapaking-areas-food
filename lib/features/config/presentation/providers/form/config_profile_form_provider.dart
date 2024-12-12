import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final configProfileFormProvider = StateNotifierProvider.family<
    ConfigProfileFormNotifier, ConfigProfileFormState, User>((ref, user) {
  final updateDataUser = ref.watch(updateDataUserProvider);
  return ConfigProfileFormNotifier(
    user: user,
    updateDataUser: updateDataUser,
  );
});

class ConfigProfileFormNotifier extends StateNotifier<ConfigProfileFormState> {
  final UpdateDataUser updateDataUser;
  ConfigProfileFormNotifier({
    required User user,
    required this.updateDataUser,
  }) : super(
          ConfigProfileFormState(
            userId: user.userId,
            email: InputEmail.dirty(user.email),
            name: InputName.dirty(user.name),
            lastName: InputName.dirty(user.lastName),
            gender: user.gender,
            phone: InputPhone.dirty(user.phone),
            direction: user.direction,
            password: InputPassword.dirty(user.password),
            isValid: true,
          ),
        );

  void onNameChanged(String value) {
    final nameValue = InputName.dirty(value);
    state = state.copyWith(
      name: nameValue,
    );
  }

  void onLastNameChanged(String value) {
    final lastNameValue = InputName.dirty(value);
    state = state.copyWith(
      lastName: lastNameValue,
    );
  }

  void onPhoneChanged(String value) {
    final phoneValue = InputPhone.dirty(value);
    state = state.copyWith(
      phone: phoneValue,
    );
  }

  void onDirectionChanged(String value) {
    state = state.copyWith(
      direction: value,
    );
  }

  void onGenderChanged(String value) {
    state = state.copyWith(
      gender: value == 'M',
    );
  }

  void onEmailChanged(String value) {
    final newValue = InputEmail.dirty(value);
    state = state.copyWith(
      email: newValue,
    );
  }

  void onViewPassword() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  void onPasswordChanged(String value) {
    final newValue = InputPassword.dirty(value);
    state = state.copyWith(
      password: newValue,
    );
  }

  Future<bool> onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return false;
    state = state.copyWith(isPosting: true);
    final result = await updateDataUser(
      UpdateDataUserParams(
        userId: state.userId,
        email: state.email.value,
        name: state.name.value,
        lastName: state.lastName.value,
        phone: state.phone.value,
        direction: state.direction,
        gender: state.gender,
        password: state.password.value,
      ),
    );
    return result.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (user) {
        state = state.copyWith(
          isPosting: false,
        );
        return true;
      },
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
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
    final name = InputName.dirty(state.name.value);
    final lastName = InputName.dirty(state.lastName.value);
    final phone = InputPhone.dirty(state.phone.value);
    final password = InputPassword.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      name: name,
      lastName: lastName,
      phone: phone,
      password: password,
      isValid: Formz.validate(
        [
          email,
          name,
          lastName,
          phone,
          password,
        ],
      ),
    );
  }
}

class ConfigProfileFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final int userId;
  final InputEmail email;
  final InputName name;
  final InputName lastName;
  final bool gender;
  final InputPhone phone;
  final String direction;
  final InputPassword password;
  final bool hasError;
  final bool obscureText;
  final String? errorMessage;

  ConfigProfileFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.userId = 0,
    this.email = const InputEmail.pure(),
    this.name = const InputName.pure(),
    this.lastName = const InputName.pure(),
    this.gender = true,
    this.phone = const InputPhone.pure(),
    this.direction = '',
    this.password = const InputPassword.pure(),
    this.hasError = false,
    this.obscureText = true,
    this.errorMessage = '',
  });

  ConfigProfileFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    int? userId,
    InputEmail? email,
    InputName? name,
    InputName? lastName,
    bool? gender,
    InputPhone? phone,
    String? direction,
    InputPassword? password,
    bool? hasError,
    bool? obscureText,
    String? errorMessage,
  }) =>
      ConfigProfileFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        direction: direction ?? this.direction,
        password: password ?? this.password,
        hasError: hasError ?? this.hasError,
        obscureText: obscureText ?? this.obscureText,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
