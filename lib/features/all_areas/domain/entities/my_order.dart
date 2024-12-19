import 'package:equatable/equatable.dart';

class MyOrder extends Equatable {
  final int orderId;
  final bool breakfast;
  final bool lunch;
  final bool dinner;
  final int userId;
  final String createdAt;

  const MyOrder({
    required this.orderId,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.userId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        orderId,
        breakfast,
        lunch,
        dinner,
        userId,
        createdAt,
      ];
}
