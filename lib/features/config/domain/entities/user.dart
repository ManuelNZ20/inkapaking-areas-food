import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String email;
  final String name;
  final String lastName;
  final bool gender;
  final String phone;
  final String direction;
  final String createAt;
  final String password;
  final String typeName;

  const User({
    required this.userId,
    required this.email,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.direction,
    required this.createAt,
    required this.password,
    required this.typeName,
  });

  @override
  List<Object?> get props => [
        userId,
        email,
        name,
        lastName,
        gender,
        phone,
        direction,
        createAt,
        password,
        typeName,
      ];
}
