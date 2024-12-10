import 'package:equatable/equatable.dart';
import 'type_user.dart';

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
  final TypeUser typeUser;

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
    required this.typeUser,
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
        typeUser,
      ];
}
