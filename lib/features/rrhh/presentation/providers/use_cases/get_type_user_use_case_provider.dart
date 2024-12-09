import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../repository/rrhh_repository_provider.dart';

final getTypeUsersUseCaseProvider = Provider<GetTypeUser>((ref) {
  final rrhhRepository = ref.watch(rrhhRepositoryProvider);
  return GetTypeUser(
    rrhhRepository,
  );
});
