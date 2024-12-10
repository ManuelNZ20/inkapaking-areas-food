import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class RRHHSupabaseDataSourceImpl implements RRHHSupabaseDataSource {
  final SupabaseClient client;

  RRHHSupabaseDataSourceImpl({required this.client});

  @override
  Future<TypeUserModel>? createTypeUser(String typeName, String description) {
    return null;
  }

  @override
  Future<TypeUserModel>? deleteTypeUser(int id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<TypeUserModel>>? getTypeUsers() async* {
    try {
      final response = client.from('type_user').stream(primaryKey: ['id']);
      await for (final event in response) {
        List<TypeUserModel> users = (event as List)
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
  Stream<List<RequestUserModel>>? getUserRequests() async* {
    try {
      final response = client
          .from('user_requests')
          .stream(primaryKey: ['id']).eq('date_accept_request', '');
      await for (final event in response) {
        List<RequestUserModel> users = (event as List)
            .map((userData) => RequestUserModel.fromJson(userData))
            .toList();
        yield users;
      }
    } catch (e) {
      // Aquí podrías emitir un error o manejar el fallo
      yield []; // O puedes emitir un stream vacío en caso de error
    }
  }

  @override
  Future<UserModel>? getUserById(int id) async {
    final response =
        await client.from('users').select().eq('id', id).limit(1).single();

    if (response.isEmpty) {
      throw GenericException('No se encontró el usuario');
    }
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel>? assignAreaToUser(int userId, int areaId) async {
    final response = await client
        .from('users')
        .update(
          {
            'user_type_id': areaId,
          },
        )
        .eq('id', userId)
        .select()
        .order('id', ascending: true)
        .limit(1)
        .single();
    if (response.isEmpty) {
      throw GenericException('No se encontró el usuario');
    }
    try {
      await client.from('user_requests').update(
        {
          'date_accept_request': DateTime.now().toString(),
        },
      ).eq('user_id', userId);
    } catch (e) {
      throw GenericException('No se pudo actualizar la solicitud');
    }
    // Crear un token de acceso
    final newToken = await client
        .from('tokens')
        .insert(
          {'state': true},
        )
        .select()
        .limit(1)
        .single();
    if (newToken.isEmpty) {
      throw GenericException('No se pudo crear el token');
    }
    await client.from('user_tokens_data').insert(
      {
        'user_id': userId,
        'token_id': newToken['id_token'],
      },
    );
    // Crear una contraseña aleatoria
    final newPassword = generatePassword();
    await client.from('users').update(
      {
        'password': newPassword,
      },
    ).eq('id', userId);
    // Enviar correo con la nueva contraseña
    final user = await getUserById(userId);
    if (user == null) {
      throw GenericException('No se encontró el usuario');
    }
    final emailSent = await _sendEmailCreateUser(user.email, newPassword);
    if (emailSent == null || !emailSent) {
      throw EmailSendException('No se pudo enviar el correo');
    }
    return UserModel.fromJson(response);
  }

  Future<bool>? _sendEmailCreateUser(String email, String newPassword) async {
    final dio = Dio();
    final headers = {
      'Authorization': 'Bearer ${Environment.apiKeyResend}',
      'Content-Type': 'application/json',
    };
    final data = {
      'from': 'InkapakingApp <${Environment.emailSender}>',
      'to': [email],
      'subject': 'Creación de cuenta',
      'html': '''
        <h1>Creación de cuenta</h1>
        <p>Se ha creado una cuenta para usted en InkapakingApp</p>
        <p>Su nueva contraseña es: $newPassword</p>
        <p>Por favor inicie sesión con su correo electrónico y la contraseña proporcionada</p>
              ''',
    };
    try {
      await dio.post(
        'https://api.resend.com/emails',
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return true;
    } on EmailSendException catch (e) {
      throw EmailSendFailure(
          'No se logro enviar el correo electronico ${e.toString()}');
    }
  }

  @override
  Future<List<RequestUserModel>>? getAcceptedRequests() async {
    final response = await client
        .from('user_requests')
        .select()
        .neq('date_accept_request', '');
    if (response.isEmpty) {
      throw GenericException('No se encontraron solicitudes aceptadas');
    }
    return response.map((e) => RequestUserModel.fromJson(e)).toList();
  }
}
