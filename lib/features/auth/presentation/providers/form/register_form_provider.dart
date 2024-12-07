import '../../../../../core/core.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final InputName name;
  final InputName lastName;
  final bool gender;
  final String phone;
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
    this.phone = '',
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
    String? phone,
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
