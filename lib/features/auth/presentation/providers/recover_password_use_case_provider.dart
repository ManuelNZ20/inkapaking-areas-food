import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final recoverPasswordProvider = Provider<RecoverPassword>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RecoverPassword(repository);
});
