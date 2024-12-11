import '../../domain/domain.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.email,
    required super.name,
    required super.lastName,
    required super.gender,
    required super.phone,
    required super.direction,
    required super.createAt,
    required super.password,
    required super.typeName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['id'] ?? 0,
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        lastName: json['last_name'] ?? '',
        gender: json['gender'] ?? true,
        phone: json['phone'] ?? '',
        direction: json['direction'] ?? '',
        createAt: json['create_at'] ?? '',
        password: json['password'] ?? '',
        typeName: json['type_user']['type_name'] ?? '',
      );
}
