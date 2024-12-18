import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final addSaucerToGeneralOrderUseCaseProvider =
    Provider<AddSaucerToGeneralOrder>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return AddSaucerToGeneralOrder(repository);
});
