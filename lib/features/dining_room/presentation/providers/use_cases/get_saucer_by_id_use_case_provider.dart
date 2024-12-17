import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getSaucerByIdUseCaseProvider = Provider<GetSaucerById>((ref) {
  final diningRoomRepository = ref.watch(diningRepositoryProvider);
  return GetSaucerById(
    diningRoomRepository,
  );
});
