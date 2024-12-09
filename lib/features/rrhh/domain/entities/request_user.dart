import 'package:equatable/equatable.dart';

class RequestUser extends Equatable {
  final int requestUserId;
  final int userId;
  final String createdAt;
  final String dateAcceptRequest;

  const RequestUser({
    required this.requestUserId,
    required this.userId,
    required this.createdAt,
    required this.dateAcceptRequest,
  });
  @override
  List<Object?> get props => [
        requestUserId,
        userId,
        createdAt,
        dateAcceptRequest,
      ];
}
