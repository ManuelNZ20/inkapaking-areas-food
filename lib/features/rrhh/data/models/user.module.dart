import '../../domain/domain.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.lastName,
    required super.gender,
    required super.address,
    required super.phone,
    required super.email,
    required super.createdAt,
    required super.typeId,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? false,
      address: json['direction'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      typeId: json['type_user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'last_name': lastName,
      'gender': gender,
      'direction': address,
      'phone': phone,
      'email': email,
      'created_at': createdAt,
      'type_user_id': typeId,
    };
  }
}
