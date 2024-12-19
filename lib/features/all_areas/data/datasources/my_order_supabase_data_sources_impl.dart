import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../dining_room/data/data.dart';
import '../../domain/domain.dart';
import '../data.dart';

class MyOrderDataSourceImpl implements MyOrderDataSource {
  final SupabaseClient client;

  MyOrderDataSourceImpl({required this.client});
  @override
  Future<List<GeneralOrderModel>>? listGeneralOrder(String createdAt) async {
    final response = await client
        .from('general_order')
        .select('''*,saucers:general_order_saucers!inner(saucer(*,schedule(*)))''').eq(
            'created_at', createdAt);
    return response.map((e) => GeneralOrderModel.fromJson(e)).toList();
  }

  @override
  Future<List<MyOrderModel>>? listMyOrders(int userId) async {
    final response = await client.from('order').select().eq('user_id', userId);
    return response.map((e) => MyOrderModel.fromJson(e)).toList();
  }

  @override
  Future<bool>? registerOrder(bool breakfast, bool lunch, bool dinner,
      int userId, String createdAt) async {
    final response = await client.from('order').insert({
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'user_id': userId,
      'created_at': createdAt,
    }).select();
    if (response.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Future<GeneralOrderModel>? getGeneralOrder(String createdAt) async {
    final response = await client
        .from('general_order')
        .select(
            '''*,saucers:general_order_saucers!inner(saucer(*,schedule(*)))''')
        .eq('created_at', createdAt)
        .limit(1)
        .single();
    return GeneralOrderModel.fromJson(response);
  }
}
