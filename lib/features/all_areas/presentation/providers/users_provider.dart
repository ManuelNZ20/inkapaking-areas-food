import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final usersNotifierProvider =
    StateNotifierProvider.autoDispose.family<UsersNotifier, UserState, int>(
  (ref, typeUserId) {
    final getUsers = ref.watch(getUsersUseCaseProvider);
    return UsersNotifier(
      getUsers: getUsers,
      typeUserId: typeUserId,
    );
  },
);

class UsersNotifier extends StateNotifier<UserState> {
  final GetUsers getUsers;
  final int typeUserId;
  UsersNotifier({
    required this.getUsers,
    required this.typeUserId,
  }) : super(
          UserState(),
        ) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true);
    final result = await getUsers(
      GetUsersParams(typeUserId: typeUserId),
    );
    result.fold(
      _handleFailure,
      _handleSuccess,
    );
    state = state.copyWith(isLoading: false);
  }

  void _handleSuccess(List<User> users) {
    state = state.copyWith(
      users: users,
      isLoading: false,
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Error al obtener los usuarios',
      );
    } else {
      _updateStateWithFailure(errorMessage: failure.toString());
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
}

class UserState {
  final List<User>? users;
  final bool? isLoading;
  final Failure? failure;
  bool get hasError => failure != null;
  final String? errorMessage;

  UserState({
    this.users = const [],
    this.isLoading = false,
    this.failure,
    this.errorMessage = '',
  });

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    Failure? failure,
    String? errorMessage,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
