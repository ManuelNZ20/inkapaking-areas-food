import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/data/data.dart';
import '../../../../core/mocks/mocks.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late AuthLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group(
    'getCurrentUser',
    () {
      final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));
      test(
        'should return UserModel from SharedPreferences when there is one in the cache',
        () async {
          // arrange
          final fileContent = fixture('user.json');
          when(mockSharedPreferences.getString(any)).thenReturn(fileContent);
          // act
          final result = await dataSource.getCurrentUser();
          // assert
          verify(mockSharedPreferences.getString('current_user'));
          expect(result, equals(tUserModel));
        },
      );

      test(
        'should return null if there is no data',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(null);
          // act
          final call = dataSource.getCurrentUser;
          // assert
          // verify(mockSharedPreferences.getString('current_user'));
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group(
    'cacheUser',
    () {
      final tUserModel = UserModel(
        userId: 1,
        name: 'Test Name',
        lastName: 'Test Last Name',
        gender: true,
        phone: '1234567890',
        direction: 'Test Direction',
        stateAccount: true,
        email: 'test@example.com',
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

      test(
        'should call SharedPreferences to cache the data',
        () async {
          // Arrange: configurar el stub para `setString`
          when(mockSharedPreferences.setString(
            any,
            any,
          )).thenAnswer((_) async =>
              true); // Aquí devolvemos `true` para simular que se guardó correctamente

          // assert
          dataSource.cacheUser(tUserModel);

          final expectedJsonString = json.encode(tUserModel.toJson());
          verify(
            mockSharedPreferences.setString(
              'current_user',
              expectedJsonString,
            ),
          ).called(1);
        },
      );
    },
  );
}
