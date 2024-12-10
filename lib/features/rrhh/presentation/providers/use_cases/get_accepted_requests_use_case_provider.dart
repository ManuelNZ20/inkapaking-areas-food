import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getAcceptedRequestUseCaseProvider = Provider<GetAcceptedRequests>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetAcceptedRequests(rrhhRepository);
});
