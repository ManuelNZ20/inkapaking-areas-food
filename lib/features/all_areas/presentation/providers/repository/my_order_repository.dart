import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/core.dart';
import '../../../data/data.dart';
import '../../../domain/domain.dart';

final myOrderDataSourceProvider = Provider<MyOrderDataSource>((ref) {
  final client = Supabase.instance.client;
  return MyOrderDataSourceImpl(client: client);
});

final networkInfoOrderProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker());
});

final myOrderRepositoryProvider = Provider<MyOrderRepository>((ref) {
  final networkInfo = ref.watch(networkInfoOrderProvider);
  final myOrderDataSource = ref.watch(myOrderDataSourceProvider);
  return MyOrderRepositoryImpl(
    networkInfo: networkInfo,
    myOrderDataSource: myOrderDataSource,
  );
});
