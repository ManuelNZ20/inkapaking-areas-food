import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../data.dart';

class UserSupabaseDataSourceImpl implements UserRemoteDataSource {
  final SupabaseClient supabaseClient;

  UserSupabaseDataSourceImpl(
    this.supabaseClient,
  );

  @override
  Future<UserModel> getUser() async {
    final response = await supabaseClient
        .from('users')
        .select('''id,name,type_user(type_name)''')
        .limit(1)
        .single();
    if (response.isEmpty) {
      throw Exception('No user found');
    }
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> getUserById(int userId) async {
    final response = await supabaseClient
        .from('users')
        .select('''*,type_user(type_name)''')
        .eq('id', userId)
        .limit(1)
        .single();
    if (response.isEmpty) {
      throw Exception('No user found');
    }
    return UserModel.fromJson(response);
  }
}
