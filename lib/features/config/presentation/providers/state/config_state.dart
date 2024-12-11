import '../../../domain/domain.dart';

class ConfigState {
  final int userId;
  final User? user;
  final bool isLoading;
  final bool isSaving;
  final bool hasError;
  final String errorMessage;

  ConfigState({
    required this.userId,
    this.user,
    this.isLoading = true,
    this.isSaving = false,
    this.hasError = false,
    this.errorMessage = '',
  });

  ConfigState copyWith({
    int? userId,
    User? user,
    bool? isLoading,
    bool? isSaving,
    bool? hasError,
    String? errorMessage,
  }) =>
      ConfigState(
        userId: userId ?? this.userId,
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
