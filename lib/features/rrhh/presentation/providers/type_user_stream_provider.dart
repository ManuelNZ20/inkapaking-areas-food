import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/core/core.dart';

import '../../domain/domain.dart';
import 'use_cases/get_type_user_use_case_provider.dart'; // Asegúrate de importar correctamente tu clase de error

// Este provider se encarga de obtener los usuarios usando el caso de uso.
final typeUsersStreamProvider =
    StreamProvider.autoDispose<List<TypeUser>>((ref) async* {
  final useCase = ref.read(getTypeUsersUseCaseProvider);
  await for (var event in useCase(NoParams())) {
    yield event.fold((l) => [], (r) => r);
  }
});

// Este provider se encarga de manejar el estado de la lista de usuarios.
final typeUsersNotifierProvider =
    StateNotifierProvider<TypeUsersNotifier, TypeUserState>((ref) {
  final useCase = ref.read(getTypeUsersUseCaseProvider);
  return TypeUsersNotifier(fetchTypeUsersUseCase: useCase);
});

class TypeUsersNotifier extends StateNotifier<TypeUserState> {
  GetTypeUsers fetchTypeUsersUseCase;
  TypeUsersNotifier({
    required this.fetchTypeUsersUseCase,
  }) : super(TypeUserState());

  void _handleFailure(Failure failure) {
    if (failure is ConnectionFailure) {
      _updateStateWithFailure(
        errorMessage: 'Credenciales incorrectas',
        hasConnection: true,
      );
    } else if (failure is ServerFailure) {
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
      failure: hasConnection ? null : ServerFailure(errorMessage),
      errorMessage: errorMessage,
    );
  }

  Future<void> loadTypeUsers() async {
    if (state.isLoading!) return;
    state = state.copyWith(isLoading: true);
    final result = fetchTypeUsersUseCase(NoParams());
    result.listen(
      (event) {
        event.fold(
          (l) => _handleFailure(l),
          (r) => state = state.copyWith(typeUsers: r),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isLoading: false);
  }
}

class TypeUserState {
  final List<TypeUser>? typeUsers;
  final bool? isLoading;
  final Failure? failure;
  bool get hasError => failure != null;
  final String? errorMessage;

  TypeUserState({
    this.typeUsers = const [],
    this.isLoading = false,
    this.failure,
    this.errorMessage = '',
  });

  TypeUserState copyWith({
    List<TypeUser>? typeUsers,
    bool? isLoading,
    Failure? failure,
    String? errorMessage,
  }) {
    return TypeUserState(
      typeUsers: typeUsers ?? this.typeUsers,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
