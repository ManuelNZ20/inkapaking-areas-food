import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/get_user_by_id.dart';
import '../providers.dart';

final getUserByIdUseCaseProvider = Provider<GetUserById>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetUserById(rrhhRepository);
});
