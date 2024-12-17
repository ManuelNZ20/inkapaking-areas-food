import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final iconsSchedule = <int, IconData>{
  3: Icons.breakfast_dining_outlined,
  4: Icons.lunch_dining_outlined,
  5: Icons.dinner_dining_outlined,
};

final schedulesProvider = FutureProvider<List<ScheduleState>>((ref) async {
  final useCase = ref.watch(getSchedulesUseCaseProvider);
  final result = await useCase(NoParams());
  return result.fold(
    (failure) => [],
    (schedules) {
      return schedules
          .map(
            (e) => ScheduleState(
              schedules: e,
              icon: iconsSchedule[e.scheduleId]!,
            ),
          )
          .toList();
    },
  );
});

class ScheduleState {
  final Schedule schedules;
  final IconData icon;

  ScheduleState({
    required this.schedules,
    required this.icon,
  });

  ScheduleState copyWith({
    Schedule? schedules,
    IconData? icon,
  }) {
    return ScheduleState(
      schedules: schedules ?? this.schedules,
      icon: icon ?? this.icon,
    );
  }
}

final listScheduleProvider =
    StateNotifierProvider<ScheduleNotifier, List<Schedule>>((ref) {
  final useCase = ref.watch(getSchedulesUseCaseProvider);
  return ScheduleNotifier(
    getSchedules: useCase,
  );
});

class ScheduleNotifier extends StateNotifier<List<Schedule>> {
  final GetSchedules getSchedules;
  ScheduleNotifier({
    required this.getSchedules,
  }) : super([]) {
    listSchedules();
  }

  Future<void> listSchedules() async {
    final result = await getSchedules(NoParams());
    result.fold(
      (failure) => state = [],
      (schedules) => state = schedules,
    );
  }
}
