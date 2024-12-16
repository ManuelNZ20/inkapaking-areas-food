import '../../domain/domain.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.lastName,
    required super.typeName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      typeName: json['type_user']['type_name'] ?? '',
    );
  }
}
