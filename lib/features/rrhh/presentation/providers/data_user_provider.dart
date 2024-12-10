import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final dataUserProvider =
    FutureProvider.family.autoDispose<User, int>((ref, userId) async {
  final useCase = await ref
      .watch(getUserByIdUseCaseProvider)
      .call(GetUserByIdParams(userId: userId));
  return useCase.fold((l) => throw (l), (r) => r);
});
