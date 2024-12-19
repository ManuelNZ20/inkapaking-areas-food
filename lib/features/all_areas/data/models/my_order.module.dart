import '../../domain/domain.dart';

class MyOrderModel extends MyOrder {
  const MyOrderModel({
    required super.orderId,
    required super.breakfast,
    required super.lunch,
    required super.dinner,
    required super.userId,
    required super.createdAt,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      orderId: json['id'] ?? 0,
      breakfast: json['breakfast'] ?? false,
      lunch: json['lunch'] ?? false,
      dinner: json['dinner'] ?? false,
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }
}
