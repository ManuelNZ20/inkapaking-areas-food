// Class: User, para el manejo de los datos de usuario
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String name;
  final String lastName;
  final bool gender;
  final String phone;
  final String direction;
  final bool stateAccount;
  final String email;
  final String password;
  final DateTime createdAt;
  final TypeUser typeUser;
  final List<Token>? tokens;
  final List<ImgUser>? imgsUser;

  const User({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.direction,
    required this.stateAccount,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.typeUser,
    required this.tokens,
    required this.imgsUser,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
        lastName,
        gender,
        phone,
        direction,
        stateAccount,
        email,
        password,
        createdAt,
        typeUser,
        tokens,
        imgsUser,
      ];
}

// Class: Token, para el manejo de los datos de token
class Token extends Equatable {
  final int tokenId;
  final String tokenAuth;
  final String tokenAccces;
  final bool state;
  final DateTime createdAt;

  const Token({
    required this.tokenId,
    required this.tokenAuth,
    required this.tokenAccces,
    required this.state,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        tokenId,
        tokenAuth,
        tokenAccces,
        state,
        createdAt,
      ];
}

// Class: ImgUser, para el manejo de los datos de imagen de usuario
class ImgUser extends Equatable {
  final int imgUserId;
  final String url;
  final DateTime createdAt;

  const ImgUser({
    required this.imgUserId,
    required this.url,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        imgUserId,
        url,
        createdAt,
      ];
}

// Class: TypeUser, para el manejo de los datos de tipo de usuario
class TypeUser extends Equatable {
  final int id;
  final String typeName;
  final String description;

  const TypeUser({
    required this.id,
    required this.typeName,
    required this.description,
  });

  @override
  List<Object?> get props => [id, typeName, description];
}
