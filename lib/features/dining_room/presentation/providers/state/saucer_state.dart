import '../../../domain/domain.dart';

class SaucerState {
  final int saucerId;
  final Saucer? saucer;
  final bool isLoading;
  final bool isSaving;

  SaucerState({
    required this.saucerId,
    this.saucer,
    this.isLoading = true,
    this.isSaving = false,
  });

  SaucerState copyWith({
    int? saucerId,
    Saucer? saucer,
    bool? isLoading,
    bool? isSaving,
  }) {
    return SaucerState(
      saucerId: saucerId ?? this.saucerId,
      saucer: saucer ?? this.saucer,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
