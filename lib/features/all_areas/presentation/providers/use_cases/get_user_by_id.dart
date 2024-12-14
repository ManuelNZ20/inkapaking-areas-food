import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getUserByIdUseCaseProvider = Provider<GetUserById>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserById(
    repository,
  );
});
