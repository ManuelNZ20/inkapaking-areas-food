import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';
import 'state/saucer_state.dart';

final saucerProvider =
    StateNotifierProvider.family<SaucerNotifier, SaucerState, int>(
  (ref, saucerId) {
    final useCase = ref.watch(getSaucerByIdUseCaseProvider);
    return SaucerNotifier(
      saucerId: saucerId,
      useCase: useCase,
    );
  },
);

class SaucerNotifier extends StateNotifier<SaucerState> {
  final GetSaucerById useCase;
  SaucerNotifier({
    required int saucerId,
    required this.useCase,
  }) : super(SaucerState(saucerId: saucerId)) {
    loadSaucer();
  }

  Saucer newEmptySaucer() {
    return Saucer(
      saucerId: 0,
      nameSaucer: '',
      nameDrink: '',
      createdAt: DateFormat('dd-MM-yyyy HH:mm:ss')
          .format(DateTime.now().toUtc().toLocal()),
      scheduleId: 0,
      schedule: const Schedule(
        scheduleId: 0,
        name: '',
        createdAt: '',
      ),
      updateAt: '',
    );
  }

  Future<void> loadSaucer() async {
    if (state.saucerId == 0) {
      state = state.copyWith(
        saucer: newEmptySaucer(),
        isLoading: false,
      );
      return;
    }
    final saucer = await useCase(GetSaucerByIdParams(state.saucerId));
    saucer.fold(
      (failure) {
        _handleFailure(failure);
      },
      (saucer) {
        state = state.copyWith(
          saucer: saucer,
          isLoading: false,
        );
      },
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Fallo el servidor',
        hasConnection: false,
      );
    } else {
      _updateStateWithFailure(
        errorMessage: 'Error desconocido',
      );
    }
  }

  void _updateStateWithFailure({
    required String errorMessage,
    bool hasConnection = true,
  }) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: errorMessage,
    );
  }
}
