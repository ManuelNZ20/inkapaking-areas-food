import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/features/auth/data/data.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
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
    typeUserId: 1,
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
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      // arrange
      final fileContent = fixture('user.json');
      final Map<String, dynamic> jsonMap = json.decode(fileContent);

      // act
      final result = UserModel.fromJson(jsonMap);

      // assert
      expect(result.userId, tUserModel.userId);
      expect(result.tokens!.length, tUserModel.tokens!.length);
      expect(result.tokens!.first.tokenId, tUserModel.tokens!.first.tokenId);
    });
  });
}
