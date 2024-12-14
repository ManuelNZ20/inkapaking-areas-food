import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final client = Supabase.instance.client;
  return UserSupabaseDataSourceImpl(
    client: client,
  );
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final userRemoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(
    networkInfo: networkInfo,
    userRemoteDataSource: userRemoteDataSource,
  );
});
