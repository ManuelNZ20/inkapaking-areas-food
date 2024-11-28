import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/presentation/providers/providers.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/mocks/mocks.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProviderContainer container;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    container = ProviderContainer(
      overrides: [
        // Sobreescribimos los proveedores con los mocks
        authRemoteDataSourceProvider
            .overrideWithValue(mockAuthRemoteDataSource),
        authLocalDataSourceProvider.overrideWithValue(mockAuthLocalDataSource),
        networkInfoProvider.overrideWithValue(mockNetworkInfo),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('AuthRepositoryProvider should create the AuthRepository correctly',
      () async {
    // Leemos el authRepositoryProvider del contenedor de pruebas
    final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockAuthRemoteDataSource.getCurrentUser(any))
        .thenAnswer((_) async => tUserModel);
    final authRepository = container.read(authRepositoryProvider);

    // Verificamos que el repositorio no es null
    expect(authRepository, isNotNull);

    // Llamada a uno de los métodos del repositorio
    final result = await authRepository.getCurrentUser('test@example.com');

    // Verificamos que el resultado es una instancia de Future
    expect(result, isA<Right>());

    // Verificamos que el repositorio interactúa con las dependencias (mockeadas)
    verify(mockAuthRemoteDataSource.getCurrentUser('test@example.com'))
        .called(1);
  });

  test('AuthRepositoryProvider should handle no internet connection', () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

    final authRepository = container.read(authRepositoryProvider);

    final result = await authRepository.getCurrentUser('test@example.com');

    // Aquí, dependiendo de cómo manejes los errores, puedes verificar si el error es el esperado
    expect(result, isA<Left>());
  });
}
