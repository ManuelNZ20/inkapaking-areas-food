import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final getAcceptedRequestsProvider =
    FutureProvider.autoDispose<List<RequestUser>>((ref) async {
  final useCase = ref.watch(getAcceptedRequestUseCaseProvider);
  final result = await useCase(NoParams());
  return result.fold(
    (l) {
      return [];
    },
    (r) {
      return r;
    },
  );
});
