import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import '../repository/auth_repository_provider.dart';

final loginProvider = Provider<SignInWithEmailAndPassword>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithEmailAndPassword(repository);
});
