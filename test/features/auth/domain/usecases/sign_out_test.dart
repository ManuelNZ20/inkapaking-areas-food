import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late SignOut usecase;
  late MockAuthRepository mockAuthRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignOut(mockAuthRepository);
  });
  final tUser = User(
    userId: 1,
    name: 'John',
    lastName: 'Doe',
    gender: true,
    phone: '123456789',
    direction: '123 Street',
    stateAccount: true,
    email: 'test@example.com',
    password: 'test123',
    createdAt: DateTime.now(),
    typeUser: const TypeUser(
      id: 1,
      typeName: 'Admin',
      description: 'Administrator',
    ),
    tokens: const [],
    imgsUser: const [],
  );
  test('should sign out user', () async {
    // Arrange
    when(mockAuthRepository.signOut()).thenAnswer((_) async => Right(tUser));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
