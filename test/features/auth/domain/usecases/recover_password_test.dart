import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void main() {
  late RecoverPassword usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RecoverPassword(mockAuthRepository);
  });

  const tEmail = 'test@example.com';

  test('should send recovery email', () async {
    // Arrange
    when(mockAuthRepository.recoverPassword(any))
        .thenAnswer((_) async => const Right(true));

    // Act
    final result = await usecase(RecoverPasswordParams(email: tEmail));

    // Assert
    expect(result, const Right(true));
    verify(mockAuthRepository.recoverPassword(tEmail));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
