import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

final configSupabaseDataSourceProvider = Provider<ConfigDataSources>((ref) {
  final client = Supabase.instance.client;

  return ConfigSupabaseDataSourcesImpl(
    client: client,
  );
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(
    InternetConnectionChecker(),
  );
});

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  final configDataSource = ref.watch(configSupabaseDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return ConfigRepositoryImpl(
    configDataSource: configDataSource,
    networkInfo: networkInfo,
  );
});
