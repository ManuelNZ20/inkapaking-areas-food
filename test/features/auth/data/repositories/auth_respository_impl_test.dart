import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:inkapaking/features/auth/data/data.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  AuthRepositoryImpl authRepositoryImpl;
  MockAuthSupabaseDataSource mockSupabaseDataSource;
  MockAuthLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockSupabaseDataSource = MockAuthSupabaseDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    authRepositoryImpl = AuthRepositoryImpl(
      supabaseDataSource: mockSupabaseDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
