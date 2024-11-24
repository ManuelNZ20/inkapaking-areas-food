import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  late SignInWithEmailAndPassword usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInWithEmailAndPassword(mockAuthRepository);
  });

  const tEmail = 'test@gmail.com';
  const tPassword = 'test123';
  final tUserTrivia = User(
    userId: 1,
    name: "John",
    lastName: "Doe",
    gender: true,
    phone: "1234567890",
    direction: "123 Main St",
    stateAccount: true,
    email: tEmail,
    password: tPassword,
    createdAt: DateTime.now(),
    typeUser: TypeUser(
      id: 1,
      typeName: 'UserArea',
      description: 'Usuario de área',
    ),
    tokens: const [],
    imgsUser: const [],
  );

  test('should return a User when the repository successfully authenticates',
      () async {
    // Arrange
    when(mockAuthRepository.signInWithEmailAndPassword(
      tEmail,
      tPassword,
    )).thenAnswer((_) async => Right(tUserTrivia));
    // Act
    final result = await usecase.execute(
      email: tEmail,
      password: tPassword,
    );

    // Assert
    expect(result, Right<Failure, User>(tUserTrivia));
    verify(mockAuthRepository.signInWithEmailAndPassword(
      tEmail,
      tPassword,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
// Ok todo funciona correctamente
// import 'package:inkapaking/core/core.dart';
// import 'package:inkapaking/features/auth/domain/domain.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'mocks.mocks.dart';

// void main() {
//   late SignInWithEmailAndPassword usecase;
//   late MockAuthRepository mockAuthRepository;

//   setUp(() {
//     mockAuthRepository = MockAuthRepository();
//     usecase = SignInWithEmailAndPassword(mockAuthRepository);
//   });

//   const tEmail = 'test@gmail.com';
//   const tPassword = 'test123';
//   final tUserTrivia = User(
//     userId: 1,
//     name: "John",
//     lastName: "Doe",
//     gender: true,
//     phone: "1234567890",
//     direction: "123 Main St",
//     stateAccount: true,
//     email: tEmail,
//     password: tPassword,
//     createdAt: DateTime.now(),
//     typeUser: TypeUser(
//       id: 1,
//       typeName: 'UserArea',
//       description: 'Usuario de área',
//     ),
//     tokens: const [],
//     imgsUser: const [],
//   );

//   test('should return a User when the repository successfully authenticates',
//       () async {
//     // Arrange
//     when(mockAuthRepository.signInWithEmailAndPassword(
//       tEmail,
//       tPassword,
//     )).thenAnswer((_) async => Right(tUserTrivia));
//     // Act
//     final result = await usecase.execute(
//       email: tEmail,
//       password: tPassword,
//     );

//     // Assert
//     expect(result, Right<Failure, User>(tUserTrivia));
//     verify(mockAuthRepository.signInWithEmailAndPassword(
//       tEmail,
//       tPassword,
//     ));
//     verifyNoMoreInteractions(mockAuthRepository);
//   });
// } 
// SEGUN ESTE TEST ME PODRÍAS DAR MÁS CASOS DE TEST PARA PROBAR
