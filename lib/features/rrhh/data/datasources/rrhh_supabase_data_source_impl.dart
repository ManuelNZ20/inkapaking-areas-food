import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RRHHSupabaseDataSourceImpl implements RRHHSupabaseDataSource {
  final SupabaseClient client;

  RRHHSupabaseDataSourceImpl({required this.client});

  @override
  Future<TypeUser>? createTypeUser(String typeName, String description) {
    return null;
  }

  @override
  Future<TypeUser>? deleteTypeUser(int id) {
    // TODO: implement deleteTypeUser
    throw UnimplementedError();
  }

  @override
  Stream<List<TypeUser>>? getTypeUsers() async* {
    try {
      final response = client.from('type_user').stream(primaryKey: ['id']);
      await for (final event in response) {
        List<TypeUser> users = (event as List)
            .map((userData) => TypeUserModel.fromJson(userData))
            .toList();

        yield users;
      }
    } catch (e) {
      // Aquí podrías emitir un error o manejar el fallo
      yield []; // O puedes emitir un stream vacío en caso de error
    }
  }

  @override
  Future<TypeUser>? updateTypeUser(
      int id, String typeName, String description) {
    // TODO: implement updateTypeUser
    throw UnimplementedError();
  }
}
