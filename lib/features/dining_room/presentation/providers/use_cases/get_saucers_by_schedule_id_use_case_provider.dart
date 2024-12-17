import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getSaucersByScheduleIdUseCaseProvider =
    Provider<GetSaucersByScheduleId>((ref) {
  final diningRoomRepository = ref.watch(diningRepositoryProvider);
  return GetSaucersByScheduleId(diningRoomRepository);
});
