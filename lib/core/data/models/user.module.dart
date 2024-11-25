import '../../core.dart';

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
      typeUser: TypeUserModel.fromJson(json['type_user'] ?? {}),
      tokens: (json['tokens'] ?? [])
          .map<TokenModel>((e) => TokenModel.fromJson(e))
          .toList(),
      imgsUser: (json['img_user'] ?? [])
          .map<ImgUserModel>((e) => ImgUserModel.fromJson(e))
          .toList(),
    );
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
  @override
  List<Object?> get props => [
        imgUserId,
        url,
        createdAt,
      ];
}
