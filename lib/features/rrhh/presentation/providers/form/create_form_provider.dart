// class RegisterNotifier extends StateNotifier<> {
//   RegisterNotifier(): super();

// }

class CreateFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String typeName;
  final String description;
  final bool hasError;
  final String? errorMessage;

  CreateFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.typeName = '',
    this.description = '',
    this.hasError = false,
    this.errorMessage = '',
  });

  CreateFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? typeName,
    String? description,
    bool? hasError,
    String? errorMessage,
  }) =>
      CreateFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        typeName: typeName ?? this.typeName,
        description: description ?? this.description,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
