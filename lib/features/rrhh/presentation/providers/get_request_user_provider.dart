import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final getRequestUserProvider =
    StreamProvider.autoDispose<List<RequestUser>>((ref) async* {
  print('getRequestUserProvider');
  final useCase = ref.watch(getRequestUserCaseProvider);
  await for (var event in useCase(NoParams())) {
    yield event.fold(
      (l) {
        print('Fallot');
        return [];
      },
      (r) {
        print('Data $r');
        return r;
      },
    );
  }
  yield [];
});
