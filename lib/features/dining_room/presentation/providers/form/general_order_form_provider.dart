import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

class GeneralOrderNotifier extends StateNotifier<GeneralOrderFormState> {
  GetSaucersByScheduleId getSaucersByScheduleId;
  GetSchedules getSchedule;
  GeneralOrderNotifier({
    required this.getSaucersByScheduleId,
    required this.getSchedule,
  }) : super(GeneralOrderFormState());

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
  final List<Saucer> totalSaucers;

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
    this.totalSaucers = const [],
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
    List<Saucer>? totalSaucers,
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
      totalSaucers: totalSaucers ?? this.totalSaucers,
    );
  }
}
