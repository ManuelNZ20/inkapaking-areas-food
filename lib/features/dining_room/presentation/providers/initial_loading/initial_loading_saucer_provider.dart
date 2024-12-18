import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  print('initialLoadingProvider');
  final step1 =
      ref.watch(breakfastSaucersByScheduleProvider(3)).saucers.isEmpty;
  final step2 = ref.watch(lunchSaucersByScheduleProvider(4)).saucers.isEmpty;
  final step3 = ref.watch(dinnerSaucersByScheduleProvider(5)).saucers.isEmpty;
  print('step1: $step1');
  print('step2: $step2');
  print('step3: $step3');
  if (step1 || step2 || step3) return true;

  return false; // terminamos de cargar
});
