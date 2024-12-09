import '../../domain/domain.dart';

class RequestUserModel extends RequestUser {
  const RequestUserModel({
    required super.requestUserId,
    required super.userId,
    required super.createdAt,
    required super.dateAcceptRequest,
  });

  factory RequestUserModel.fromJson(Map<String, dynamic> json) {
    return RequestUserModel(
      requestUserId: json['id'],
      userId: json['user_id'],
      createdAt: json['created_at'] ?? '',
      dateAcceptRequest: json['date_accept_request'] ?? '',
    );
  }
}
