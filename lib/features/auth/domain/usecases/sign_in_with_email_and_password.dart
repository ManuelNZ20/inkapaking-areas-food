import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';

class SignInWithEmailAndPassword
    implements AuthUseCase<User, SignInWithEmailAndPasswordParams> {
  final AuthRepository authRepository;

  SignInWithEmailAndPassword(this.authRepository);

  /// Llama al método [signInWithEmailAndPassword] del repositorio [AuthRepository] y retorna un [Either] con un [Failure] o un [User]
  @override
  Future<Either<Failure, User>> call(
    SignInWithEmailAndPasswordParams params,
  ) async {
    final email = InputEmail.dirty(params.email);
    final password = InputPassword.dirty(params.password);
    if (email.isValid && password.isValid) {
      return authRepository.signInWithEmailAndPassword(
        params.email,
        params.password,
      )!;
    } else {
      return Left(
        AuthenticationFailure(
          'Email o contraseña incorrectos',
        ),
      );
    }
  }

  Future<Either<Failure, User>> checkAuthentication(
      KeyValueStorageService keyValueStorageService) async {
    final tokenValue = await keyValueStorageService.getValue<int>('token');
    if (tokenValue != null) {
      final user = await authRepository.getCurrentUserByToken(tokenValue);
      if (user != null) {
        return user;
      }
      return Left(
        ServerFailure(
          'Fallo en el servidor',
        ),
      );
    }
    return Left(
      AuthenticationFailure(
        'No se ha iniciado sesión',
      ),
    );
  }
}

class SignInWithEmailAndPasswordParams {
  final String email;
  final String password;

  SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
