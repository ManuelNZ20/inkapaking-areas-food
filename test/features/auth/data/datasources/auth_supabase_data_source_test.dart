// import 'package:flutter_test/flutter_test.dart';
// import 'package:inkapaking/features/auth/data/data.dart';
// import 'package:mockito/mockito.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../../core/mocks/mocks.mocks.dart';

// void main() {
//   late AuthRemoteDataSourceImpl dataSource;
//   late MockSupabaseClient mockSupabaseClient;
//   late MockPostgrestFilterBuilder<PostgrestList> mockFilterBuilder;

//   setUp(() {
//     mockSupabaseClient = MockSupabaseClient();
//     mockFilterBuilder = MockPostgrestFilterBuilder<PostgrestList>();
//     dataSource = AuthRemoteDataSourceImpl(
//       client: mockSupabaseClient,
//     );
//   });

//   group(
//     'getCurrentUser',
//     () {
//       // El test debe ser asíncrono. Y realizar las siguientes acciones:
//       // Arrange: Configurar los mocks y las respuestas esperadas.
//       // Act: Llamar al método que se desea probar.
//       // Assert: Verificar que el resultado es el esperado.
//       // El test hace lo siguiente:
//       // 1. Configura los mocks para devolver el builder y la respuesta esperada.
//       // 2. Llama al método que se desea probar.
//       // 3. Verifica que el resultado es el esperado.

//       test(
//         'should fetch data from Supabase',
//         () async {
//           // Arrange
//           const mockResponse = {
//             'id': 1,
//             'name': 'Test',
//             'last_name': 'Last Test Name',
//             'email': 'test@example.com',
//             'password': 'Test123',
//             'phone': '123456789',
//             'gender': true,
//             'direction': 'Test Direction',
//             'state_account': false,
//           };

//           // Configurar los mocks para devolver el builder y la respuesta esperada.
//           when(mockSupabaseClient.from('user').select())
//               .thenReturn(mockFilterBuilder);
//           when(mockFilterBuilder.select()).thenReturn(mockFilterBuilder);
//           when(mockFilterBuilder.eq('email', 'test@example.com'))
//               .thenReturn(mockFilterBuilder);
//           when(mockFilterBuilder.single() as Map<String, dynamic>)
//               .thenAnswer((_) => mockResponse);
//           // Act
//           final result = await dataSource.getCurrentUser('test@example.com');

//           // Assert
//           expect(result, mockResponse);

//           // Verify
//           verify(mockSupabaseClient.from('user')).called(1);
//           verify(mockFilterBuilder.select()).called(1);
//           verify(mockFilterBuilder.eq('email', 'test@example.com')).called(1);
//           verify(mockFilterBuilder.single()).called(1);
//           verifyNoMoreInteractions(mockSupabaseClient);
//         },
//       );
//     },
//   );
// }
