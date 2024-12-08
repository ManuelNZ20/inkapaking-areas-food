import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/core/core.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';

final rrhhSupabaseDataSourceProvider = Provider<RRHHSupabaseDataSource>((ref) {
  final client = Supabase.instance.client;
  return RRHHSupabaseDataSourceImpl(client: client);
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

final rrhhRepositoryProvider = Provider<RRHHRepository>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  final remoteDataSource = ref.watch(rrhhSupabaseDataSourceProvider);
  return RRHHRepositoryImpl(
    networkInfo: networkInfo,
    remoteDataSource: remoteDataSource,
  );
});
