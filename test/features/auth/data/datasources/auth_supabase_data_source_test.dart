import 'package:flutter_test/flutter_test.dart';
import 'package:inkapaking/features/auth/data/data.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late AuthSupabaseDataSourceImpl dataSource;
  late MockSupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    dataSource = AuthSupabaseDataSourceImpl(
      client: mockSupabaseClient,
    );
  });

  group(
    'getCurrentUser',
    () {
      test(
        'should fetch data from Supabase',
        () async {
          // Arrange: Preparar los datos que el mock debe devolver
          const mockResponse = PostgrestResponse(
            data: [
              {
                'id': 1,
                'name': 'Test Name',
                'email': 'test@example.com',
                'last_name': 'Test Last Name',
                'phone': '123456789',
                'direction': 'Test Direction',
                'state_account': true,
                'password': 'Test123',
              }
            ],
            count: 0,
          );

          // Mock: Indicamos que cuando se llame al método `select` del cliente de Supabase, devuelva el mockResponse
          when(mockSupabaseClient
                  .from('user')
                  .select()
                  .eq('email', 'test@example.com')
                  .single() as Future<PostgrestResponse>)
              .thenAnswer(
            (_) async => mockResponse,
          );

          // Assert: Verificamos que el resultado es el que esperamos
          final result = await dataSource.getCurrentUser('test@example.com');
          expect(result, mockResponse.data);
          // Verify: Verificamos que el método `select` del cliente de Supabase fue llamado
          verify(mockSupabaseClient
                  .from('user')
                  .select()
                  .eq('email', 'test@example.com')
                  .single())
              .called(1);
          // Verify: Verificamos que no se llamó a otros métodos del cliente de Supabase
          verifyNoMoreInteractions(mockSupabaseClient);
        },
      );
    },
  );
}
