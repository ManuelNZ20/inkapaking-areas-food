import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final generalOrderFormProvider =
    StateNotifierProvider<GeneralOrderNotifier, GeneralOrderFormState>((ref) {
  final addSaucerToGeneralOrder =
      ref.watch(addSaucerToGeneralOrderUseCaseProvider);
  final createGeneralOrder = ref.watch(createGeneralOrderUseCaseProvider);
  return GeneralOrderNotifier(
    addSaucerToGeneralOrder: addSaucerToGeneralOrder,
    createGeneralOrder: createGeneralOrder,
  );
});

class GeneralOrderNotifier extends StateNotifier<GeneralOrderFormState> {
  AddSaucerToGeneralOrder addSaucerToGeneralOrder;
  CreateGeneralOrder createGeneralOrder;
  GeneralOrderNotifier({
    required this.addSaucerToGeneralOrder,
    required this.createGeneralOrder,
  }) : super(GeneralOrderFormState());

  Future<bool> onSaucerSubmit(
    BuildContext context,
    int breakfast,
    int lunch,
    int dinner,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) async {
    state = state.copyWith(isPosting: true);
    final result = await createGeneralOrder(CreateGeneralOrderParams(
      startDate: startTime.format(context),
      endDate: endTime.format(context),
      createdAt:
          DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal()),
    ));

    final response = result.fold(
      (failure) {
        state = state.copyWith(isPosting: false);
        _handleFailure(failure);
      },
      (generalOrder) async {
        state = state.copyWith(
          isPosting: false,
          generalOrderId: generalOrder.generalOrderId,
        );
        final result = await addSaucerToGeneralOrder(
          AddSaucerToGeneralOrderParams(
            generalOrderId: generalOrder.generalOrderId,
            saucerId: [
              breakfast,
              lunch,
              dinner,
            ],
          ),
        );
        final response = result.fold(
          (failure) {
            _handleFailure(failure);
            state = state.copyWith(
              isPosting: false,
            );
            return false;
          },
          (success) {
            state = state.copyWith(
              isPosting: false,
            );
            _resetState();
            return true;
          },
        );
        return response;
      },
    );
    return await response ?? false;
  }

  void _resetState() {
    state = GeneralOrderFormState();
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Server Failure',
        failure: failure,
      );
      return;
    }
    _updateStateWithFailure(
      errorMessage: 'Unexpected Error',
      failure: failure,
    );
  }

  void _updateStateWithFailure({
    required String errorMessage,
    Failure? failure,
  }) {
    state = state.copyWith(
      isPosting: false,
      failure: failure,
      errorMessage: errorMessage,
    );
  }
}

class GeneralOrderFormState {
  final bool isFormValid;
  final bool isPosting;
  final int? generalOrderId;
  final String createdAt;
  final Failure? failure;
  final String? errorMessage;
  GeneralOrderFormState({
    this.isFormValid = false,
    this.isPosting = false,
    this.generalOrderId = 0,
    this.createdAt = '',
    this.failure,
    this.errorMessage,
  });

  GeneralOrderFormState copyWith({
    bool? isFormValid,
    bool? isPosting,
    int? generalOrderId,
    String? createdAt,
    Failure? failure,
    String? errorMessage,
  }) {
    return GeneralOrderFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      isPosting: isPosting ?? this.isPosting,
      generalOrderId: generalOrderId ?? this.generalOrderId,
      createdAt: createdAt ?? this.createdAt,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
