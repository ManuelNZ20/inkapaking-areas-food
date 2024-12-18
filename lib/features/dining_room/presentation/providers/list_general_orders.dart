import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final generalNotifierProvider =
    StateNotifierProvider<GeneralNotifier, List<GeneralOrder>>((ref) {
  final getListGeneralOrders = ref.watch(getGeneralOrderWithSaucersUseCase);
  return GeneralNotifier(
    getListGeneralOrders: getListGeneralOrders,
  );
});

class GeneralNotifier extends StateNotifier<List<GeneralOrder>> {
  final GetListGeneralOrders getListGeneralOrders;
  GeneralNotifier({
    required this.getListGeneralOrders,
  }) : super([]) {
    listGeneralOrders();
  }

  Future<void> listGeneralOrders() async {
    final result = await getListGeneralOrders(NoParams());
    result.fold(
      (failure) => state = [],
      (generalOrders) => state = generalOrders,
    );
  }
}
