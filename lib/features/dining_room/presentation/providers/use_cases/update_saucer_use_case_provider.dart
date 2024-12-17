import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final updateSaucerUseCaseProvider = Provider<UpdateSaucer>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return UpdateSaucer(repository);
});
