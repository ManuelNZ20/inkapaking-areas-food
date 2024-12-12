import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final updateDataUserProvider = Provider<UpdateDataUser>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return UpdateDataUser(
    configRepository,
  );
});
