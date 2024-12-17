import 'package:inkapaking/core/core.dart';

import '../../../domain/domain.dart';

class SaucerState {
  final int saucerId;
  final Saucer? saucer;
  final bool isLoading;
  final bool isSaving;
  final Failure? failure;
  final String? errorMessage;

  SaucerState({
    required this.saucerId,
    this.saucer,
    this.isLoading = true,
    this.isSaving = false,
    this.failure,
    this.errorMessage,
  });

  SaucerState copyWith({
    int? saucerId,
    Saucer? saucer,
    bool? isLoading,
    bool? isSaving,
    Failure? failure,
    String? errorMessage,
  }) {
    return SaucerState(
      saucerId: saucerId ?? this.saucerId,
      saucer: saucer ?? this.saucer,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
