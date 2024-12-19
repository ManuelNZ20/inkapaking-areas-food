import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';
import '../providers.dart';

final myOrderFormProvider =
    StateNotifierProvider.autoDispose<MyOrderNotifier, MyOrderFormState>((ref) {
  final createMyOrder = ref.watch(createMyOrderUseCaseProvider);
  return MyOrderNotifier(
    createMyOrder: createMyOrder,
  );
});

class MyOrderNotifier extends StateNotifier<MyOrderFormState> {
  CreateMyOrder createMyOrder;
  MyOrderNotifier({
    required this.createMyOrder,
  }) : super(MyOrderFormState());

  void onBreakfastChange(bool? value) {
    state = state.copyWith(breakfast: value);
  }

  void onLunchChange(bool? value) {
    state = state.copyWith(lunch: value);
  }

  void onDinnerChange(bool? value) {
    state = state.copyWith(dinner: value);
  }

  Future<bool> createOrder(
    int userId,
  ) async {
    final createdAt =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
    state = state.copyWith(isPosting: true);
    final result = await createMyOrder(CreateMyOrderParams(
      userId: userId,
      breakfast: state.breakfast,
      lunch: state.lunch,
      dinner: state.dinner,
      createdAt: createdAt,
    ));
    state = state.copyWith(isPosting: false);
    final create = result.fold(
      (l) => false,
      (r) => r,
    );
    return create;
  }
}

class MyOrderFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool breakfast;
  final bool lunch;
  final bool dinner;
  final int userId;
  final String createdAt;

  MyOrderFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.breakfast = false,
    this.lunch = false,
    this.dinner = false,
    this.userId = 0,
    this.createdAt = '',
  });

  MyOrderFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? breakfast,
    bool? lunch,
    bool? dinner,
    int? userId,
    String? createdAt,
  }) =>
      MyOrderFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        breakfast: breakfast ?? this.breakfast,
        lunch: lunch ?? this.lunch,
        dinner: dinner ?? this.dinner,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
      );
}
