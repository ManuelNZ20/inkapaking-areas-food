import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AuthRepository,
  AuthSupabaseDataSource,
  AuthLocalDataSource,
  NetworkInfo,
  InternetConnectionChecker,
])
void main() {}
