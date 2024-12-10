import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getRequestUserUseCaseProvider = Provider<GetRequestUser>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetRequestUser(
    rrhhRepository,
  );
});
