import 'dart:convert';
import 'package:inkapaking/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    final prefs = await getSharedPrefs();
    await prefs.setString('current_user', json.encode(user.toJson()));
  }

  @override
  Future<void> deleteAuthToken() async {
    final prefs = await getSharedPrefs();
    await prefs.remove('auth_token');
  }

  @override
  Future<void> deleteCurrentUser() async {
    final prefs = await getSharedPrefs();
    await prefs.remove('current_user');
  }

  @override
  Future<void> deleteUserState(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getAuthToken() async {
    final prefs = await getSharedPrefs();
    return prefs.getString('auth_token');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = await getSharedPrefs();
    final userJson = prefs.getString('current_user');
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
    final prefs = await getSharedPrefs();
    return prefs.containsKey('current_user');
  }

  @override
  Future<void> saveAuthToken(String token) async {
    final prefs = await getSharedPrefs();
    await prefs.setString('auth_token', token);
  }

  @override
  Future<void> saveCurrentUser(UserModel user) async {
    final prefs = await getSharedPrefs();
    await prefs.setString('current_user', json.encode(user.toJson()));
  }

  @override
  Future<void> saveUserState(String key, value) async {
    throw UnimplementedError();
  }
}
