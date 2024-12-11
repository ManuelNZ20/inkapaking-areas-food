import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';

class ConfigProfileFormNotifier extends StateNotifier<ConfigProfileFormState> {
  ConfigProfileFormNotifier()
      : super(
          ConfigProfileFormState(),
        );
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
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
