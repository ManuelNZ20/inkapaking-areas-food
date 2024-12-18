import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final createGeneralOrderUseCaseProvider = Provider<CreateGeneralOrder>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return CreateGeneralOrder(repository);
});
