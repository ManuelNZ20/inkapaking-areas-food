import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/core.dart';
import 'package:mockito/mockito.dart';

import 'package:inkapaking/features/auth/data/data.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthSupabaseDataSource mockSupabaseDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(
    () {
      mockSupabaseDataSource = MockAuthSupabaseDataSource();
      mockLocalDataSource = MockAuthLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      authRepositoryImpl = AuthRepositoryImpl(
        supabaseDataSource: mockSupabaseDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
      );
    },
  );

  void runTestsOnline(Function body) {
    group(
      'device is online',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      },
    );
  }

  void runTestsOffline(Function body) {
    group(
      'device is offline',
      () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      },
    );
  }

  group(
    'getCurrentUser',
    () {
      const tEmail = 'test@example.com';
      final tUserModel = UserModel(
        userId: 1,
        name: 'Test Name',
        lastName: 'Test Last Name',
        gender: true,
        phone: '1234567890',
        direction: 'Test Direction',
        stateAccount: true,
        email: tEmail,
        password: 'test123',
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        typeUser: const TypeUserModel(
          id: 1,
          typeName: 'Test Type User',
          description: 'Test Description',
        ),
        tokens: [
          TokenModel(
            tokenId: 1,
            tokenAuth: 'Test Token Auth',
            tokenAccces: 'Test Token Access',
            state: true,
            createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          ),
        ],
        imgsUser: [
          ImgUserModel(
            imgUserId: 1,
            url: 'Test URL',
            createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
          ),
        ],
      );
      final User tUser = tUserModel;
      // El test verifica si el dispositivo esta conectado a internet
      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.getCurrentUser(any)).thenAnswer(
            (_) async => tUserModel,
          );
          // act
          await authRepositoryImpl.getCurrentUser(tEmail);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      // El test verifica si el dispositivo no esta conectado a internet
      runTestsOnline(
        () {
          // Inicializa el test
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });
          // El test prueba si el dispositivo esta conectado a internet y si el usuario se encuentra en la base de datos
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.getCurrentUser(any)).thenAnswer(
                (_) async => tUserModel,
              );
              final result = await authRepositoryImpl.getCurrentUser(tEmail);

              verify(mockSupabaseDataSource.getCurrentUser(tEmail));
              expect(result, equals(Right(tUser)));
            },
          );
        },
      );

      test(
        'should save the user locally when the call to remote data source is successful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.getCurrentUser(any)).thenAnswer(
            (_) async => tUserModel,
          );
          await authRepositoryImpl.getCurrentUser(tEmail);
          verify(mockLocalDataSource.saveCurrentUser(tUserModel));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.getCurrentUser(any)).thenThrow(
            ServerException(),
          );
          final result = await authRepositoryImpl.getCurrentUser(tEmail);
          verify(mockSupabaseDataSource.getCurrentUser(tEmail));
          verifyNoMoreInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );

      runTestsOffline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });

          test(
            'should return last locally cached data when the cached data is present',
            () async {
              when(mockLocalDataSource.getCurrentUser()).thenAnswer(
                (_) async => tUserModel,
              );
              final result = await authRepositoryImpl.getCurrentUser(tEmail);
              verifyZeroInteractions(mockSupabaseDataSource);
              verify(mockLocalDataSource.getCurrentUser());
              expect(result, equals(Right(tUser)));
            },
          );
        },
      );
      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          when(mockLocalDataSource.getCurrentUser()).thenThrow(
            CacheException(),
          );
          final result = await authRepositoryImpl.getCurrentUser(tEmail);
          verifyZeroInteractions(mockSupabaseDataSource);
          verify(mockLocalDataSource.getCurrentUser());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    },
  );
}
