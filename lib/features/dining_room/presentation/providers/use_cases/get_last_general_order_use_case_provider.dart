import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getLastGeneralOrderUseCaseProvider = Provider<GetLastGeneralOrder>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return GetLastGeneralOrder(
    repository,
  );
});
