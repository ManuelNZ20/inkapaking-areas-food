import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final assignAreaFormProvider =
    StateNotifierProvider<AssignNotifier, AssignFormState>((ref) {
  final getTypeUserUseCase = ref.watch(getTypeUsersUseCaseProvider);
  final assignAreaNewUserUseCase = ref.watch(assignAreaNewUserUseCaseProvider);
  return AssignNotifier(
    getTypeUserUseCase: getTypeUserUseCase,
    assignAreaNewUserUseCase: assignAreaNewUserUseCase,
  );
});

class AssignNotifier extends StateNotifier<AssignFormState> {
  GetTypeUser getTypeUserUseCase;
  AssignAreaNewUser assignAreaNewUserUseCase;
  AssignNotifier({
    required this.getTypeUserUseCase,
    required this.assignAreaNewUserUseCase,
  }) : super(AssignFormState());

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
      isPosting: false,
      errorMessage: errorMessage,
      hasError: true,
    );
  }

  Future<void> loadTypeUsers(int userId) async {
    if (state.isLoading!) return;
    state = state.copyWith(isLoading: true);
    final result = getTypeUserUseCase(NoParams());
    result.listen((event) {
      event.fold(
        _handleFailure,
        (r) => state = state.copyWith(
          typeUsers: r,
          userId: userId,
          typeUserId: r.first.typeUserId,
        ),
      );
    });
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(
      isLoading: false,
    );
  }

  Future<bool> assignAreaNewUser(int typeId) async {
    if (state.isPosting!) return false;
    state = state.copyWith(isPosting: true);
    final result = await assignAreaNewUserUseCase(AssignAreaNewUserParams(
      areaId: typeId,
      userId: state.userId!,
    ));
    result.fold(
      _handleFailure,
      (r) {
        state = state.copyWith(
          isFormPosted: true,
          typeUsers: state.typeUsers!
              .where((element) => element.typeUserId != typeId)
              .toList(),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(isPosting: false);
    return result.isRight();
  }

  void onTypeUserChanged(int value) {
    state = state.copyWith(
      typeUserId: value,
      typeUserSelected: state.typeUsers!.firstWhere(
        (element) => element.typeUserId == value,
      ),
    );
  }
}

class AssignFormState {
  final bool? isPosting;
  final bool? isLoading;
  final bool? isFormPosted;
  final int? typeUserId;
  final int? userId;
  final List<TypeUser>? typeUsers;
  final TypeUser? typeUserSelected;
  final bool hasError;
  final String? errorMessage;

  AssignFormState({
    this.isPosting = false,
    this.isLoading = false,
    this.isFormPosted = false,
    this.typeUserId = 0,
    this.userId = 0,
    this.hasError = false,
    this.errorMessage = '',
    this.typeUsers = const [],
    this.typeUserSelected,
  });

  AssignFormState copyWith({
    bool? isPosting,
    bool? isLoading,
    bool? isFormPosted,
    int? typeUserId,
    int? userId,
    bool? hasError,
    String? errorMessage,
    List<TypeUser>? typeUsers,
    TypeUser? typeUserSelected,
  }) =>
      AssignFormState(
        isPosting: isPosting ?? this.isPosting,
        isLoading: isLoading ?? this.isLoading,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        typeUserId: typeUserId ?? this.typeUserId,
        userId: userId ?? this.userId,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
        typeUsers: typeUsers ?? this.typeUsers,
        typeUserSelected: typeUserSelected ?? this.typeUserSelected,
      );
}
