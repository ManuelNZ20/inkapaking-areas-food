import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:inkapaking/core/core.dart';
import 'package:dio/dio.dart';
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
    final newPassword = generatePassword();
    final updateResult = await updatePassword(email, newPassword);
    if (updateResult == null || !updateResult) {
      throw ServerException('No se pudo actualizar la contraseña');
    }
    final sendEmail = await sendRecoveryEmail(email, newPassword);
    if (sendEmail == null || !sendEmail) {
      throw ServerException('No se pudo enviar el correo de recuperación');
    }
    return true;
  }

  @override
  Future<bool>? updatePassword(String email, String newPassword) async {
    final response = await client
        .from(tableNameAuth)
        .update({'password': newPassword})
        .eq('email', email)
        .select();

    if (response.isEmpty) {
      throw UnauthorizedException('Usuario no encontrado');
    }
    return true;
  }

  @override
  Future<bool>? sendRecoveryEmail(String email, String newPassword) async {
    final dio = Dio();
    final headers = {
      'Authorization': 'Bearer ${Environment.apiKeyResend}',
      'Content-Type': 'application/json',
    };
    final data = {
      'from': 'InkapakingApp <${Environment.emailSender}>',
      'to': [email],
      'subject': 'Recuperación de contraseña',
      'html': '''
        <h1>Recuperación de contraseña</h1>
        <p>Se ha solicitado la recuperación de contraseña, si no has sido tu ignora este mensaje.</p>
        <p>Si has sido tu, por favor ingresa la siguiente contraseña: <strong>$newPassword</strong></p>
        <p>Gracias por confiar en nosotros.</p>
        <p>Atentamente, InkapakingApp</p>
        <p>Este mensaje es generado automáticamente, por favor no responder.</p>
        <p>Si tienes alguna duda o problema, por favor contacta con nosotros a través de nuestro correo: ${Environment.emailSender}</p>
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
  Future<UserModel>? signInWithEmailAndPassword(
      String email, String password) async {
    final response = await client
        .from(tableNameAuth)
        .select(queryFieldsFromAuth)
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
    print('Verificando correo');
    final verifyEmail = await _sendEmailVerification(email);
    if (verifyEmail == null || !verifyEmail) {
      throw const EmailSendFailure(
          'No se pudo enviar el correo de verificación');
    }
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

  Future<bool?> _sendEmailVerification(String email) async {
    final dio = Dio();
    final headers = {
      'Authorization': 'Bearer ${Environment.apiKeyResend}',
      'Content-Type': 'application/json',
    };
    final data = {
      'from': 'InkapakingApp <${Environment.emailSender}>',
      'to': [email],
      'subject': 'Verificación de correo',
      'html': '''
        <h1>Verificación de correo</h1>
        <p>Se ha registrado en InkapakingApp, por favor verifique su correo electrónico.</p>
        <p>Gracias por confiar en nosotros.</p>
        <p>Atentamente, InkapakingApp</p>
        <p>Este mensaje es generado automáticamente, por favor no responder.</p>
        <p>Si tienes alguna duda o problema, por favor contacta con nosotros a través de nuestro correo: ${Environment.emailSender}</p>
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
  Future<UserModel>? getCurrentUserByToken(int tokenId) async {
    final responseToken = await client
        .from('user_tokens_data')
        .select()
        .eq('token_id', tokenId)
        .limit(1)
        .single();

    final response = await client
        .from(tableNameAuth)
        .select('''*,type_user(*),tokens(*),img_user(*)''')
        .eq('id', responseToken['user_id'])
        .limit(1)
        .single();

    return UserModel.fromJson(response);
  }
}
