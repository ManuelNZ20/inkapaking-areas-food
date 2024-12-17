import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final saucersByScheduleProvider = StateNotifierProvider.family
    .autoDispose<SaucersNotifier, List<Saucer>, int>((ref, scheduleId) {
  final getSaucerByScheduleId =
      ref.watch(getSaucersByScheduleIdUseCaseProvider);
  return SaucersNotifier(
    scheduleId: scheduleId,
    getSaucerByScheduleId: getSaucerByScheduleId,
  );
});

class SaucersNotifier extends StateNotifier<List<Saucer>> {
  final GetSaucersByScheduleId getSaucerByScheduleId;
  final int scheduleId;
  int from = 0;
  int to = 10;
  bool isLoading = false;
  SaucersNotifier({
    required this.scheduleId,
    required this.getSaucerByScheduleId,
  }) : super([]) {
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
        print('Failure: $failure');
        return null;
      },
      (saucers) {
        state = [
          ...state,
          ...saucers,
        ];
      },
    );
  }

  Future<void> reset() async {
    from = 0;
    to = 10;
    state = [];
    loadNextPage();
  }
}
