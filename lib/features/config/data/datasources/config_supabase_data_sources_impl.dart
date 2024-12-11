import 'package:inkapaking/features/config/data/models/user.module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';

class ConfigSupabaseDataSourcesImpl implements ConfigDataSources {
  final SupabaseClient client;

  ConfigSupabaseDataSourcesImpl({
    required this.client,
  });
  @override
  Future<UserModel>? configGetUserById(int userId) async {
    final response = await client
        .from('users')
        .select('''*,type_user(type_name)''')
        .eq('id', userId)
        .limit(1)
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel>? configUpdateData(
      int userId,
      String email,
      String name,
      String lastName,
      bool gender,
      String phone,
      String direction,
      String password) async {
    final response = await client
        .from('users')
        .update({
          'email': email,
          'name': name,
          'last_name': lastName,
          'gender': gender,
          'phone': phone,
          'direction': direction,
          'password': password,
        })
        .eq('id', userId)
        .select()
        .limit(1)
        .single();
    return UserModel.fromJson(response);
  }
}
