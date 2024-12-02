import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:inkapaking/core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel>? getCurrentUser(String email) async {
    final response = await client
        .from(tableNameAuth)
        .select(queryFieldsFromAuth)
        .eq('email', email)
        .limit(1)
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<bool>? recoverPassword(String email) async {
    final response = await client
        .from(tableNameAuth)
        .select(queryFieldsFromAuth)
        .eq('email', email)
        .limit(1)
        .single();
    return response.isEmpty;
  }

  @override
  Future<UserModel>? signInWithEmailAndPassword(
      String email, String password) async {
    final response = await client
        .from(tableNameAuth)
        .select('''*,type_user(*),tokens(*),img_user(*)''')
        .eq('email', email)
        .eq('password', password)
        .limit(1);
    if (response.isEmpty) {
      throw UnauthorizedException('Usuario o contraseña incorrecta');
    }
    final user = UserModel.fromJson(response.first);
    return user;
  }

  @override
  Future<UserModel>? signOut() {
    return null;
  }

  @override
  Future<UserModel>? signUpWithDataUser(
    String name,
    String lastName,
    bool gender,
    String phone,
    String direction,
    bool stateAccount,
    String email,
  ) async {
    final response = await client
        .from(tableNameAuth)
        .insert(
          {
            'name': name,
            'last_name': lastName,
            'gender': gender,
            'phone': phone,
            'direction': direction,
            'state_account': stateAccount,
            'email': email,
          },
        )
        .select()
        .limit(1)
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel>? getCurrentUserByToken(String token) {
    throw UnimplementedError();
  }
}
