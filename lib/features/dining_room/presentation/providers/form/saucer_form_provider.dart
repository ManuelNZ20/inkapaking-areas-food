import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final saucerFormProvider =
    StateNotifierProvider.family<SaucerFormNotifier, SaucerFormState, Saucer>(
        (ref, saucer) {
  final updateSaucer = ref.watch(updateSaucerUseCaseProvider);
  final createSaucer = ref.watch(createSaucerUseCaseProvider);
  return SaucerFormNotifier(
    updateSaucer: updateSaucer,
    createSaucer: createSaucer,
    saucer: saucer,
  );
});

class SaucerFormNotifier extends StateNotifier<SaucerFormState> {
  UpdateSaucer? updateSaucer;
  CreateSaucer? createSaucer;
  SaucerFormNotifier({
    this.updateSaucer,
    this.createSaucer,
    required Saucer saucer,
  }) : super(
          SaucerFormState(
            saucerId: saucer.saucerId,
            nameSaucer: saucer.nameSaucer,
            nameDrink: saucer.nameDrink,
            scheduleId: saucer.scheduleId,
            isFormValid: true,
          ),
        );
  void onNameSaucerChanged(String value) {
    final nameSaucer = value;
    state = state.copyWith(
      nameSaucer: nameSaucer,
      isFormValid: nameSaucer.isNotEmpty,
    );
  }

  void onNameDrinkChanged(String value) {
    final nameDrink = value;
    state = state.copyWith(
      nameDrink: nameDrink,
      isFormValid: nameDrink.isNotEmpty,
    );
  }

  void onScheduleIdChanged(Set<int> value) {
    final scheduleId = value;
    state = state.copyWith(
      scheduleId: scheduleId.first,
      isFormValid: scheduleId.isNotEmpty,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    state = state.copyWith(
      isPosting: true,
      errorMessage: null,
      isFormValid: true,
      failure: null,
    );
    if (state.saucerId == 0) {
      final saucer = await createSaucer!(
        CreateSaucerParams(
          nameSaucer: state.nameSaucer,
          nameDrink: state.nameDrink,
          scheduleId: state.scheduleId,
          createdAt: state.updateAt!,
        ),
      );
      final result = saucer.fold(
        (failure) {
          _handleFailure(failure);
          return false;
        },
        (saucer) {
          state = state.copyWith(
            saucerId: saucer.saucerId,
          );
          return true;
        },
      );
      return result;
    }
    final saucer = await updateSaucer!(
      UpdateSaucerParams(
        saucerId: state.saucerId!,
        nameSaucer: state.nameSaucer,
        nameDrink: state.nameDrink,
        scheduleId: state.scheduleId,
        updateAt: state.updateAt!,
      ),
    );
    final result = saucer.fold(
      (failure) {
        _handleFailure(failure);
        return false;
      },
      (saucer) {
        return true;
      },
    );
    return result;
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
      errorMessage: errorMessage,
    );
  }
}

class SaucerFormState {
  final bool isFormValid;
  final bool isPosting;
  final int? saucerId;
  final String nameSaucer;
  final String nameDrink;
  final int scheduleId;
  final Failure? failure;
  final String? errorMessage;
  String? updateAt = DateFormat('dd-MM-yyyy HH:mm:ss')
      .format(DateTime.now().toUtc().toLocal());

  SaucerFormState({
    required this.isFormValid,
    this.isPosting = false,
    required this.saucerId,
    required this.nameSaucer,
    required this.nameDrink,
    required this.scheduleId,
    this.failure,
    this.errorMessage,
    this.updateAt,
  });

  SaucerFormState copyWith({
    bool? isFormValid,
    bool? isPosting,
    int? saucerId,
    String? nameSaucer,
    String? nameDrink,
    int? scheduleId,
    Failure? failure,
    String? errorMessage,
    String? updateAt,
  }) {
    return SaucerFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      isPosting: isPosting ?? this.isPosting,
      saucerId: saucerId ?? this.saucerId,
      nameSaucer: nameSaucer ?? this.nameSaucer,
      nameDrink: nameDrink ?? this.nameDrink,
      scheduleId: scheduleId ?? this.scheduleId,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      updateAt: updateAt ?? this.updateAt,
    );
  }
}
