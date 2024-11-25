import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/auth/data/data.dart';
import 'package:inkapaking/features/auth/domain/domain.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AuthRepository,
  AuthSupabaseDataSource,
  AuthLocalDataSource,
  NetworkInfo,
])
void main() {}
