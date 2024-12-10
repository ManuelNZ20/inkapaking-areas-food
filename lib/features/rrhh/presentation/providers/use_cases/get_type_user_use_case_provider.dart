import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final getTypeUsersUseCaseProvider = Provider<GetTypeUsers>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetTypeUsers(
    rrhhRepository,
  );
});
