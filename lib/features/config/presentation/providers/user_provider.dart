import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final userProvider =
    StateNotifierProvider.family.autoDispose<ConfigNotifier, ConfigState, int>((
  ref,
  userId,
) {
  final getConfig = ref.watch(
    getUserByIdUseCaseProvider,
  );
  return ConfigNotifier(
    userId: userId,
    getConfig: getConfig,
  );
});

class ConfigNotifier extends StateNotifier<ConfigState> {
  final GetUserById getConfig;
  ConfigNotifier({
    required int userId,
    required this.getConfig,
  }) : super(ConfigState(
          userId: userId,
        )) {
    loadUser();
  }

  Future<void> loadUser() async {
    state = state.copyWith(isLoading: true);
    final result = await getConfig(
      GetUserByIdParams(
        userId: state.userId,
      ),
    );
    result.fold(
      _handleFailure,
      _handleSuccess,
    );
  }

  void _handleSuccess(User user) {
    state = state.copyWith(
      isLoading: false,
      user: user,
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Error en el servidor',
        hasConnection: true,
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
      isSaving: false,
      hasError: true,
      errorMessage: errorMessage,
    );
  }
}
