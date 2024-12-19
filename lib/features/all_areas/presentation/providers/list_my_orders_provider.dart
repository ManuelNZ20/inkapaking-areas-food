import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final listMyOrdersProvider =
    StateNotifierProvider.family<ListMyOrdersNotifier, ListMyOrderState, int>((
  ref,
  userId,
) {
  final getMyOrdersByUserId = ref.watch(getMyOrdersByUserIdProvider);
  return ListMyOrdersNotifier(
    userId: userId,
    getMyOrdersByUserId: getMyOrdersByUserId,
  );
});

class ListMyOrdersNotifier extends StateNotifier<ListMyOrderState> {
  final GetMyOrdersByUserId getMyOrdersByUserId;
  final int userId;
  ListMyOrdersNotifier({
    required this.userId,
    required this.getMyOrdersByUserId,
  }) : super(ListMyOrderState());
  Future<void> listMyOrders() async {
    state = state.copyWith(isLoading: true);
    final result =
        await getMyOrdersByUserId(GetMyOrdersByUserIdParams(userId: userId));
    result.fold(
      _handleFailure,
      (orders) => state = state.copyWith(
        isLoading: false,
        orders: orders,
      ),
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerFailure) {
      _updateStateWithFailure(
        errorMessage: 'Failed to connect to server',
      );
    } else {
      _updateStateWithFailure(
        errorMessage: 'Unexpected error',
      );
    }
  }

  void _updateStateWithFailure({
    required String errorMessage,
  }) {
    state = state.copyWith(
      isLoading: false,
      hasError: true,
      errorMessage: errorMessage,
    );
  }

  void reset() {
    state = ListMyOrderState();
  }
}

class ListMyOrderState {
  final List<MyOrder> orders;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  ListMyOrderState({
    this.orders = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
  });

  ListMyOrderState copyWith({
    List<MyOrder>? orders,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return ListMyOrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
