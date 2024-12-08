import 'package:equatable/equatable.dart';

class TypeUser extends Equatable {
  final int typeUserId;
  final String typeName;
  final String description;

  const TypeUser({
    required this.typeUserId,
    required this.typeName,
    required this.description,
  });
  @override
  List<Object?> get props => [
        typeUserId,
        typeName,
        description,
      ];
}
