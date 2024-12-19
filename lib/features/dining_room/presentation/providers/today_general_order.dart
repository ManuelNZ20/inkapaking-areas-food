import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final todayGeneralOrderProvider = FutureProvider<GeneralOrder>((ref) async {
  final getTodayGeneralOrder = ref.read(getTodayGeneralOrderUseCaseProvider);
  final createAt =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
  final result = await getTodayGeneralOrder(
      GetTodayGeneralOrderParams(createAt: createAt));
  return result.fold((l) => throw l, (r) => r);
});
final todayGenralOrderStreamProvider =
    StreamProvider<GeneralOrder>((ref) async* {
  final getTodayGeneralOrder = ref.read(getTodayGeneralOrderUseCaseProvider);
  final createAt =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
  final result = await getTodayGeneralOrder(
      GetTodayGeneralOrderParams(createAt: createAt));
  yield* result.fold((l) => throw l, (r) => Stream.value(r));
});
