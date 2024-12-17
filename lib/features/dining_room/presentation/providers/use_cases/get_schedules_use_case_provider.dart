import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final getSchedulesUseCaseProvider = Provider<GetSchedules>((ref) {
  final diningRoomRepository = ref.watch(diningRepositoryProvider);
  return GetSchedules(
    diningRoomRepository,
  );
});
