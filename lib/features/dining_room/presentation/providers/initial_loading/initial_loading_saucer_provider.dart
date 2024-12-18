import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(breakfastSaucersByScheduleProvider(3)).isEmpty;
  final step2 = ref.watch(lunchSaucersByScheduleProvider(5)).isEmpty;
  final step3 = ref.watch(dinnerSaucersByScheduleProvider(6)).isEmpty;

  if (step1 || step2 || step3) return true;

  return false; // terminamos de cargar
});
