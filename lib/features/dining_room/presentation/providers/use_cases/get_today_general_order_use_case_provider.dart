import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getTodayGeneralOrderUseCaseProvider =
    Provider<GetTodayGeneralOrder>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return GetTodayGeneralOrder(repository);
});
