import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late GetCurrentUser usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentUser(mockAuthRepository);
  });
  const tEmail = 'test@example.com';
  final tUser = User(
    userId: 1,
    name: 'John',
    lastName: 'Doe',
    gender: true,
    phone: '123456789',
    direction: '123 Street',
    stateAccount: true,
    email: tEmail,
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

  test('should return current User', () async {
    // Arrange
    when(mockAuthRepository.getCurrentUser(any))
        .thenAnswer((_) async => Right(tUser));

    // Act
    final result = await usecase(GetCurrentUserParams(email: tEmail));

    // Assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.getCurrentUser(tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
