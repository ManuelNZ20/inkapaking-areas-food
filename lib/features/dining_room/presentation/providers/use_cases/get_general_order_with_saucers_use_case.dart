import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getGeneralOrderWithSaucersUseCase = Provider<GetListGeneralOrders>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return GetListGeneralOrders(repository);
});
