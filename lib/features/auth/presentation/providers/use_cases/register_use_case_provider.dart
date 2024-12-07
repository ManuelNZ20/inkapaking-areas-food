import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final registerProvider = Provider<SignUpWithDataUser>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpWithDataUser(repository);
});
