import 'dart:convert';
import 'package:inkapaking/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/domain.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
        'current_user', json.encode(user.toJson()));
  }

  @override
  Future<void> deleteAuthToken() async {
    await sharedPreferences.remove('auth_token');
  }

  @override
  Future<void> deleteCurrentUser() async {
    await sharedPreferences.remove('current_user');
  }

  @override
  Future<void> deleteUserState(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getAuthToken() async {
    return sharedPreferences.getString('auth_token');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userJson = sharedPreferences.getString('current_user');
    if (userJson != null) {
      return Future.value(UserModel.fromJson(json.decode(userJson)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future getUserState(String key) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasUser() async {
    return sharedPreferences.containsKey('current_user');
  }

  @override
  Future<void> saveAuthToken(String token) async {
    await sharedPreferences.setString('auth_token', token);
  }

  @override
  Future<void> saveCurrentUser(UserModel user) async {
    await sharedPreferences.setString(
        'current_user', json.encode(user.toJson()));
  }

  @override
  Future<void> saveUserState(String key, value) async {
    throw UnimplementedError();
  }
}
