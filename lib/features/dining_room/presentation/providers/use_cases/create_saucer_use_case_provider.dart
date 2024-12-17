import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final createSaucerUseCaseProvider = Provider<CreateSaucer>((ref) {
  final repository = ref.watch(diningRepositoryProvider);
  return CreateSaucer(repository);
});
