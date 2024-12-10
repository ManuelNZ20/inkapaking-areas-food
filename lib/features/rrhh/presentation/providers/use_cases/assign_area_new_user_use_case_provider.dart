import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final assignAreaNewUserUseCaseProvider = Provider<AssignAreaNewUser>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return AssignAreaNewUser(rrhhRepository);
});
