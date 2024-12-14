import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String name;
  final String typeName;

  const User({
    required this.userId,
    required this.name,
    required this.typeName,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        typeName,
      ];
}
