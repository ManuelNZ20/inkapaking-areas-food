import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../dining_room/data/data.dart';
import '../../../dining_room/domain/domain.dart';

final getGeneralOrderWithSaucersProvider =
    FutureProvider<GeneralOrder?>((ref) async {
  final client = Supabase.instance.client;
  final createdAt =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
  final response = await client
      .from('general_order')
      .select(
          '''*,saucers:general_order_saucers!inner(saucer(*,schedule(*)))''')
      .eq('created_at', createdAt)
      .limit(1);
  if (response.isEmpty) {
    return null;
  }
  return GeneralOrderModel.fromJson(response.first);
});
