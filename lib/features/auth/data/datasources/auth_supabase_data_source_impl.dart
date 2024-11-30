import 'package:inkapaking/features/auth/data/models/user.module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';

const tableName = 'user';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel>? getCurrentUser(String email) async {
    final response = await client
        .from(tableName)
        .select()
        .eq('email', email)
        .limit(1)
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<bool>? recoverPassword(String email) async {
    final response = await client
        .from(tableName)
        .select()
        .eq('email', email)
        .limit(1)
        .single();
    return response.isEmpty;
  }

  @override
  Future<UserModel>? signInWithEmailAndPassword(
      String email, String password) async {
    final response = await client
        .from(tableName)
        .select()
        .eq('email', email)
        .eq('password', password)
        .limit(1)
        .single();
    return UserModel.fromJson(response);
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
        .from(tableName)
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
}
