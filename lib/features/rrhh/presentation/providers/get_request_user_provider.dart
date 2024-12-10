import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final getRequestUserProvider =
    StreamProvider.autoDispose<List<RequestUser>>((ref) async* {
  final useCase = ref.watch(getRequestUserUseCaseProvider);
  await for (var event in useCase(NoParams())) {
    yield event.fold(
      (l) {
        return [];
      },
      (r) {
        return r;
      },
    );
  }
  yield [];
});
