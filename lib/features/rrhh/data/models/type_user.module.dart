import '../../domain/domain.dart';

class TypeUserModel extends TypeUser {
  const TypeUserModel({
    required super.typeUserId,
    required super.typeName,
    required super.description,
  });

  factory TypeUserModel.fromJson(Map<String, dynamic> json) {
    return TypeUserModel(
      typeUserId: json['id'],
      typeName: json['type_name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': typeUserId,
      'type_name': typeName,
      'description': description,
    };
  }
}
