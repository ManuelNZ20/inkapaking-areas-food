import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getTodayGeneralOrderStreamUseCaseProvider =
    Provider<GetLastGeneralOrderStream>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return GetLastGeneralOrderStream(
    repository,
  );
});
