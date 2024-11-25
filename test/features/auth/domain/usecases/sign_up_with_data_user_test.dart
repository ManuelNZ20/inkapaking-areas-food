import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:inkapaking/core/core.dart';
import 'mocks.mocks.dart';

void main() {
  late SignUpWithDataUser usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignUpWithDataUser(mockAuthRepository);
  });

  final tUser = User(
    userId: 1,
    name: "John",
    lastName: "Doe",
    gender: true,
    phone: "1234567890",
    direction: "123 Main St",
    stateAccount: true,
    email: "jane.doe@gmail.com",
    password: "securePassword123",
    createdAt: DateTime.now(),
    typeUser: TypeUser(
      id: 1,
      typeName: 'UserArea',
      description: 'Usuario de área',
    ),
    tokens: const [],
    imgsUser: const [],
  );

  test('should return a User when the repository successfully signs up',
      () async {
    // Arrange
    when(mockAuthRepository.signUpWithDataUser(
      any,
      any,
      any,
      any,
      any,
      any,
      any,
    )).thenAnswer((_) async => Right(tUser));

    // Act
    final result = await usecase.call(
      SignUpWithDataUserParams(
        name: tUser.name,
        lastName: tUser.lastName,
        gender: tUser.gender,
        phone: tUser.phone,
        direction: tUser.direction,
        stateAccount: tUser.stateAccount,
        email: tUser.email,
      ),
    );

    // Assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.signUpWithDataUser(
      tUser.name,
      tUser.lastName,
      tUser.gender,
      tUser.phone,
      tUser.direction,
      tUser.stateAccount,
      tUser.email,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
