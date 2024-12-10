import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getDetailUserWithTypeUserProvider =
    Provider<GetDetailUserWithTypeUser>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetDetailUserWithTypeUser(rrhhRepository);
});
