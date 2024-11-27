import 'package:inkapaking/core/data/models/user.module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';

const tableName = 'users';

class AuthSupabaseDataSourceImpl implements AuthSupabaseDataSource {
  final SupabaseClient client;

  AuthSupabaseDataSourceImpl({required this.client});

  @override
  Future<UserModel>? getCurrentUser(String email) {
    return null;
  }

  @override
  Future<bool>? recoverPassword(String email) {
    return null;
  }

  @override
  Future<UserModel>? signInWithEmailAndPassword(String email, String password) {
    return null;
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
      String email) {
    return null;
    // final response = await client.from(tableName).insert({
    //   'name': name,
    //   'last_name': lastName,
    //   'gender': gender,
    //   'phone': phone,
    //   'direction': direction,
    //   'state_account': stateAccount,
    //   'email': email,
    // }).select();
  }
}
