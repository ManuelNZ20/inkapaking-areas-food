import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getMyOrdersByUserIdProvider = Provider<GetMyOrdersByUserId>((ref) {
  final repository = ref.watch(myOrderRepositoryProvider);
  return GetMyOrdersByUserId(repository);
});
