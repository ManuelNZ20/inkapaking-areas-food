import '../../domain/domain.dart';

class UserModel extends User {
  const UserModel({
    required super.userId,
    required super.name,
    required super.lastName,
    required super.gender,
    required super.phone,
    required super.direction,
    required super.stateAccount,
    required super.email,
    required super.password,
    required super.createdAt,
    required super.typeUser,
    required super.tokens,
    required super.imgsUser,
    required super.typeUserId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      gender: json['gender'] ?? false,
      phone: json['phone'] ?? '',
      direction: json['direction'] ?? '',
      stateAccount: json['state_account'] ?? false,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      typeUserId: json['type_user_id'] ?? 0,
      typeUser: TypeUserModel.fromJson(json['type_user'] ?? {}),
      tokens: (json['tokens'] ?? [])
          .map<TokenModel>((e) => TokenModel.fromJson(e))
          .toList(),
      imgsUser: (json['img_user'] ?? [])
          .map<ImgUserModel>((e) => ImgUserModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'last_name': lastName,
      'phone': phone,
      'direction': direction,
      'state_account': stateAccount,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'type_user': <String, dynamic>{
        'id': typeUser.id,
        'type_name': typeUser.typeName,
        'description': typeUser.description,
      },
      'tokens': tokens!.map((e) {
        return <String, dynamic>{
          'id': e.tokenId,
          'token_auth': e.tokenAuth,
          'token_access': e.tokenAccces,
          'state': e.state,
          'created_at': e.createdAt.toIso8601String(),
        };
      }).toList(),
      'img_user': imgsUser!.map((e) {
        return <String, dynamic>{
          'id': e.imgUserId,
          'url': e.url,
          'created_at': e.createdAt.toIso8601String(),
        };
      }).toList(),
    };
  }

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

class TypeUserModel extends TypeUser {
  const TypeUserModel({
    required super.id,
    required super.typeName,
    required super.description,
  });

  factory TypeUserModel.fromJson(Map<String, dynamic> json) {
    return TypeUserModel(
      id: json['id'] ?? 0,
      typeName: json['type_name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_name': typeName,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        id,
        typeName,
        description,
      ];
}

class TokenModel extends Token {
  const TokenModel({
    required super.tokenId,
    required super.tokenAuth,
    required super.tokenAccces,
    required super.state,
    required super.createdAt,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      tokenId: json['id_token'] ?? 0,
      tokenAuth: json['token_auth'] ?? '',
      tokenAccces: json['token_access'] ?? '',
      state: json['state'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_token': tokenId,
      'token_auth': tokenAuth,
      'token_access': tokenAccces,
      'state': state,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        tokenId,
        tokenAuth,
        tokenAccces,
        state,
        createdAt,
      ];
}

class ImgUserModel extends ImgUser {
  const ImgUserModel({
    required super.imgUserId,
    required super.url,
    required super.createdAt,
  });

  factory ImgUserModel.fromJson(Map<String, dynamic> json) {
    return ImgUserModel(
      imgUserId: json['id'] ?? 0,
      url: json['url'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': imgUserId,
      'url': url,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        imgUserId,
        url,
        createdAt,
      ];
}
