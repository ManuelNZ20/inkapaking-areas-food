import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final createMyOrderUseCaseProvider = Provider<CreateMyOrder>((ref) {
  final repository = ref.watch(myOrderRepositoryProvider);
  return CreateMyOrder(repository);
});
