import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDataSource,
  NetworkInfo,
  InternetConnectionChecker,
  SupabaseClient,
])
void main() {}
