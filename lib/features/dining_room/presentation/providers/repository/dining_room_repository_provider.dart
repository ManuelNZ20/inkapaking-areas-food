import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

final diningRoomDataSourceProvider =
    Provider<DiningRoomRemoteDataSource>((ref) {
  final client = Supabase.instance.client;
  return DiningRoomSupabaseDataSourceImpl(
    client: client,
  );
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

final diningRepositoryProvider = Provider<DiningRoomRepository>((ref) {
  final remoteDataSource = ref.watch(diningRoomDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return DiningRoomRepositoryImpl(
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );
});
