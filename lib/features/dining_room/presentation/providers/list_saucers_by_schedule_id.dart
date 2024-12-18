import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final breakfastSaucersByScheduleProvider =
    StateNotifierProvider.family<SaucersNotifier, SaucersState, int>(
        (ref, scheduleId) {
  final getSaucerByScheduleId =
      ref.watch(getSaucersByScheduleIdUseCaseProvider);
  return SaucersNotifier(
    scheduleId: scheduleId,
    getSaucerByScheduleId: getSaucerByScheduleId,
  );
});

final lunchSaucersByScheduleProvider =
    StateNotifierProvider.family<SaucersNotifier, SaucersState, int>(
        (ref, scheduleId) {
  final getSaucerByScheduleId =
      ref.watch(getSaucersByScheduleIdUseCaseProvider);
  return SaucersNotifier(
    scheduleId: scheduleId,
    getSaucerByScheduleId: getSaucerByScheduleId,
  );
});

final dinnerSaucersByScheduleProvider =
    StateNotifierProvider.family<SaucersNotifier, SaucersState, int>(
        (ref, scheduleId) {
  final getSaucerByScheduleId =
      ref.watch(getSaucersByScheduleIdUseCaseProvider);
  return SaucersNotifier(
    scheduleId: scheduleId,
    getSaucerByScheduleId: getSaucerByScheduleId,
  );
});

final saucersByScheduleProvider =
    StateNotifierProvider.family<SaucersNotifier, SaucersState, int>(
        (ref, scheduleId) {
  final getSaucerByScheduleId =
      ref.watch(getSaucersByScheduleIdUseCaseProvider);
  return SaucersNotifier(
    scheduleId: scheduleId,
    getSaucerByScheduleId: getSaucerByScheduleId,
  );
});

class SaucersNotifier extends StateNotifier<SaucersState> {
  final GetSaucersByScheduleId getSaucerByScheduleId;
  final int scheduleId;
  int from = 0;
  int to = 10;
  bool isLoading = false;
  SaucersNotifier({
    required this.scheduleId,
    required this.getSaucerByScheduleId,
  }) : super(SaucersState()) {
    reset();
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    final result = await getSaucerByScheduleId(
      GetSaucersByScheduleIdParams(
        scheduleId: scheduleId,
        from: from,
        to: to,
      ),
    );
    isLoading = false;
    from = to;
    to += 10;
    Future.delayed(
      const Duration(milliseconds: 300),
    );
    result.fold(
      (failure) {
        return null;
      },
      (saucers) {
        state = state.copyWith(
          saucers: List.of(state.saucers)..addAll(saucers),
          selectedSaucerId: saucers.isNotEmpty ? saucers.first.saucerId : 0,
        );
      },
    );
  }

  Future<void> reset() async {
    from = 0;
    to = 10;
    state = SaucersState();
    loadNextPage();
  }

  void selectSaucer(int? saucerId) {
    state = state.copyWith(
      selectedSaucerId: saucerId,
    );
  }
}

class SaucersState {
  final List<Saucer> saucers;
  final int selectedSaucerId;

  SaucersState({
    this.saucers = const [],
    this.selectedSaucerId = 0,
  });

  SaucersState copyWith({
    List<Saucer>? saucers,
    int? selectedSaucerId,
  }) {
    return SaucersState(
      saucers: saucers ?? this.saucers,
      selectedSaucerId: selectedSaucerId ?? this.selectedSaucerId,
    );
  }
}
