import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String name;
  final String lastName;
  final String typeName;

  const User({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.typeName,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        lastName,
        typeName,
      ];
}
