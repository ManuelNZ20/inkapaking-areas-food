import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String name;
  final String lastName;
  final bool gender;
  final String address;
  final String phone;
  final String email;
  final DateTime createdAt;
  final int typeId;

  const User({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.address,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.typeId,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        lastName,
        gender,
        address,
        phone,
        email,
        createdAt,
        typeId,
      ];
}
