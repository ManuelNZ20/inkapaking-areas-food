import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/core.dart';
import 'package:mockito/mockito.dart';

import 'package:inkapaking/features/auth/data/data.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource mockSupabaseDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(
    () {
      mockSupabaseDataSource = MockAuthRemoteDataSource();
      mockLocalDataSource = MockAuthLocalDataSource();
      mockNetworkInfo = MockNetworkInfo();
      authRepositoryImpl = AuthRepositoryImpl(
        remoteDataSource: mockSupabaseDataSource,
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

  group(
    'login',
    () {
      const tEmail = 'test@gmail.com';
      const tPassword = 'test123';
      final tUserModel = UserModel(
        userId: 1,
        name: 'Test Name',
        lastName: 'Test Last Name',
        gender: true,
        phone: '1234567890',
        direction: 'Test Direction',
        stateAccount: true,
        email: tEmail,
        password: tPassword,
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

      test(
        'should check if the device is online',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.signInWithEmailAndPassword(any, any))
              .thenAnswer(
            (_) async => tUserModel,
          );
          await authRepositoryImpl.signInWithEmailAndPassword(
              tEmail, tPassword);
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });

          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.signInWithEmailAndPassword(any, any))
                  .thenAnswer(
                (_) async => tUserModel,
              );
              final result = await authRepositoryImpl
                  .signInWithEmailAndPassword(tEmail, tPassword);

              verify(mockSupabaseDataSource.signInWithEmailAndPassword(
                tEmail,
                tPassword,
              ));
              expect(result, equals(Right(tUser)));
            },
          );

          test(
            'should save the user locally when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.signInWithEmailAndPassword(any, any))
                  .thenAnswer(
                (_) async => tUserModel,
              );
              await authRepositoryImpl.signInWithEmailAndPassword(
                  tEmail, tPassword);
              verify(mockLocalDataSource.saveCurrentUser(tUserModel));
            },
          );

          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              when(mockSupabaseDataSource.signInWithEmailAndPassword(any, any))
                  .thenThrow(
                ServerException(),
              );
              final result = await authRepositoryImpl
                  .signInWithEmailAndPassword(tEmail, tPassword);
              verify(mockSupabaseDataSource.signInWithEmailAndPassword(
                tEmail,
                tPassword,
              ));
              verifyNoMoreInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });

          test(
            'should return server failure when the device is offline',
            () async {
              final result = await authRepositoryImpl
                  .signInWithEmailAndPassword(tEmail, tPassword);
              verifyZeroInteractions(mockSupabaseDataSource);
              verifyZeroInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );
    },
  );

  group(
    'recoverPassword',
    () {
      const tEmail = 'test@example.com';
      // El test verifica si el dispositivo esta conectado a internet
      test(
        'should check if the device is online',
        () async {
          // el recoverPassword devuelve un bool
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.recoverPassword(any)).thenAnswer(
            (_) async => true,
          );
          await authRepositoryImpl.recoverPassword(tEmail);
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });
          // El test verifica si el dispositivo esta conectado a internet y si el usuario se encuentra en la base de datos
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.recoverPassword(any)).thenAnswer(
                (_) async => true,
              );
              final result = await authRepositoryImpl.recoverPassword(tEmail);

              verify(mockSupabaseDataSource.recoverPassword(tEmail));
              expect(result, equals(const Right(true)));
            },
          );

          // El test verifica si el dispositivo esta conectado a internet y si el usuario no se encuentra en la base de datos
          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              when(mockSupabaseDataSource.recoverPassword(any)).thenThrow(
                ServerException(),
              );
              final result = await authRepositoryImpl.recoverPassword(tEmail);
              verify(mockSupabaseDataSource.recoverPassword(tEmail));
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });
          // El test verifica si el dispositivo no esta conectado a internet
          test(
            'should return server failure when the device is offline',
            () async {
              final result = await authRepositoryImpl.recoverPassword(tEmail);
              verifyZeroInteractions(mockSupabaseDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );
    },
  );

  group(
    'signOut',
    () {
      final tUserModel = UserModel(
        userId: 1,
        name: 'Test Name',
        lastName: 'Test Last Name',
        gender: true,
        phone: '1234567890',
        direction: 'Test Direction',
        stateAccount: true,
        email: 'test@gmail.com',
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
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.signOut()).thenAnswer(
            (_) async => tUserModel,
          );
          await authRepositoryImpl.signOut();
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });

          // El test verifica si el dispositivo esta conectado a internet y si el usuario se encuentra en la base de datos
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.signOut()).thenAnswer(
                (_) async => tUserModel,
              );
              final result = await authRepositoryImpl.signOut();

              verify(mockSupabaseDataSource.signOut());
              expect(result, equals(Right(tUser)));
            },
          );

          // El test verifica si el dispositivo esta conectado a internet y si el usuario no se encuentra en la base de datos
          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              when(mockSupabaseDataSource.signOut()).thenThrow(
                ServerException(),
              );
              final result = await authRepositoryImpl.signOut();
              verify(mockSupabaseDataSource.signOut());
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });

          // El test verifica si el dispositivo no esta conectado a internet
          test(
            'should return server failure when the device is offline',
            () async {
              final result = await authRepositoryImpl.signOut();
              verifyZeroInteractions(mockSupabaseDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );
    },
  );

  group(
    'signUpWithDataUser',
    () {
      const tEmail = 'test@gmail.com';
      const tPassword = 'test123';
      final tUserModel = UserModel(
        userId: 1,
        name: 'Test Name',
        lastName: 'Test Last Name',
        gender: true,
        phone: '1234567890',
        direction: 'Test Direction',
        stateAccount: true,
        email: tEmail,
        password: tPassword,
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
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSupabaseDataSource.signUpWithDataUser(
            any,
            any,
            any,
            any,
            any,
            any,
            any,
          )).thenAnswer(
            (_) async => tUserModel,
          );
          await authRepositoryImpl.signUpWithDataUser(
            'Test Name',
            'Test Last Name',
            true,
            '1234567890',
            'Test Direction',
            true,
            tEmail,
          );
          verify(mockNetworkInfo.isConnected);
        },
      );

      // El test verifica si el dispositivo esta conectado a internet
      runTestsOnline(
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });

          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.signUpWithDataUser(
                any,
                any,
                any,
                any,
                any,
                any,
                any,
              )).thenAnswer(
                (_) async => tUserModel,
              );
              final result = await authRepositoryImpl.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              );

              verify(mockSupabaseDataSource.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              ));
              expect(result, equals(Right(tUser)));
            },
          );
          // El test verifica si el dispositivo esta conectado a internet y si el usuario no se encuentra en la base de datos
          test(
            'should save the user locally when the call to remote data source is successful',
            () async {
              when(mockSupabaseDataSource.signUpWithDataUser(
                any,
                any,
                any,
                any,
                any,
                any,
                any,
              )).thenAnswer(
                (_) async => tUserModel,
              );
              await authRepositoryImpl.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              );
              verify(mockLocalDataSource.saveCurrentUser(tUserModel));
            },
          );
          // El test verifica si el dispositivo esta conectado a internet y si el usuario no se encuentra en la base de datos y se produce un error
          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              when(mockSupabaseDataSource.signUpWithDataUser(
                any,
                any,
                any,
                any,
                any,
                any,
                any,
              )).thenThrow(
                ServerException(),
              );
              final result = await authRepositoryImpl.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              );
              verify(mockSupabaseDataSource.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              ));
              verifyNoMoreInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          // El test verifica si el dispositivo no esta conectado a internet
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });

          // El test verifica si el dispositivo no esta conectado a internet
          test(
            'should return server failure when the device is offline',
            () async {
              final result = await authRepositoryImpl.signUpWithDataUser(
                'Test Name',
                'Test Last Name',
                true,
                '1234567890',
                'Test Direction',
                true,
                tEmail,
              );
              verifyZeroInteractions(mockSupabaseDataSource);
              verifyZeroInteractions(mockLocalDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );
    },
  );
}
