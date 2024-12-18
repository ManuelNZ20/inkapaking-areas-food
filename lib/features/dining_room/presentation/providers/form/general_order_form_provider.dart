import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

class GeneralOrderNotifier extends StateNotifier<GeneralOrderFormState> {
  GeneralOrderNotifier() : super(GeneralOrderFormState());

  void onStartDateChanged(TimeOfDay value) {
    final startDate = value;
    state = state.copyWith(
      startDate: startDate,
    );
  }

  void onEndDateChanged(TimeOfDay value) {
    final endDate = value;
    state = state.copyWith(
      endDate: endDate,
    );
  }

  void onBreakfastSaucerSelected(int value) {
    final breakfastSaucerSelected = value;
    state = state.copyWith(
      breakfastSaucerSelected: breakfastSaucerSelected,
    );
  }

  void onLunchSaucerSelected(int value) {
    final lunchSaucerIdSelected = value;
    state = state.copyWith(
      lunchSaucerIdSelected: lunchSaucerIdSelected,
    );
  }

  void onDinnerSaucerSelected(int value) {
    final dinnerSaucerIdSelected = value;
    state = state.copyWith(
      dinnerSaucerIdSelected: dinnerSaucerIdSelected,
    );
  }
}

class GeneralOrderFormState {
  final bool isFormValid;
  final bool isPosting;
  final int? generalOrderId;
  final TimeOfDay? startDate;
  final TimeOfDay? endDate;
  final String createdAt;
  final int breakfastSaucerSelected;
  final int lunchSaucerIdSelected;
  final int dinnerSaucerIdSelected;

  GeneralOrderFormState({
    this.isFormValid = false,
    this.isPosting = false,
    this.generalOrderId = 0,
    this.startDate,
    this.endDate,
    this.createdAt = '',
    this.breakfastSaucerSelected = 0,
    this.lunchSaucerIdSelected = 0,
    this.dinnerSaucerIdSelected = 0,
  });

  GeneralOrderFormState copyWith({
    bool? isFormValid,
    bool? isPosting,
    int? generalOrderId,
    TimeOfDay? startDate,
    TimeOfDay? endDate,
    String? createdAt,
    int? breakfastSaucerSelected,
    int? lunchSaucerIdSelected,
    int? dinnerSaucerIdSelected,
  }) {
    return GeneralOrderFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      isPosting: isPosting ?? this.isPosting,
      generalOrderId: generalOrderId ?? this.generalOrderId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      breakfastSaucerSelected:
          breakfastSaucerSelected ?? this.breakfastSaucerSelected,
      lunchSaucerIdSelected:
          lunchSaucerIdSelected ?? this.lunchSaucerIdSelected,
      dinnerSaucerIdSelected:
          dinnerSaucerIdSelected ?? this.dinnerSaucerIdSelected,
    );
  }
}
