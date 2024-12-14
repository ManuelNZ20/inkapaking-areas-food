import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getUsersUseCaseProvider = Provider<GetUsers>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsers(
    repository,
  );
});
