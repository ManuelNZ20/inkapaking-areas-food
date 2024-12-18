import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../data.dart';

class DiningRoomSupabaseDataSourceImpl extends DiningRoomRemoteDataSource {
  final SupabaseClient client;

  DiningRoomSupabaseDataSourceImpl({required this.client});
  @override
  Future<SaucerModel>? createSaucer(
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String createdAt,
  ) async {
    final response = await client
        .from('saucer')
        .insert({
          'name_saucer': nameSaucer,
          'name_drink': nameDrink,
          'schedule_id': scheduleId,
          'created_at': createdAt,
        })
        .select('''*,schedule(*)''')
        .limit(1)
        .single();
    return SaucerModel.fromJson(response);
  }

  @override
  Future<bool>? deleteSaucer(
    int saucerId,
  ) async {
    final response =
        await client.from('saucer').delete().eq('id', saucerId).select();
    return response.isNotEmpty;
  }

  @override
  Future<List<SaucerModel>>? listSaucers() async {
    final response = await client.from('saucer').select('''*,schedule(*)''');
    return response.map((e) => SaucerModel.fromJson(e)).toList();
  }

  @override
  Future<List<ScheduleModel>>? listSchedules() async {
    final response = await client.from('schedule').select();
    return response.map((e) => ScheduleModel.fromJson(e)).toList();
  }

  @override
  Future<SaucerModel>? updateSaucer(
    int saucerId,
    String nameSaucer,
    String nameDrink,
    int scheduleId,
    String updateAt,
  ) async {
    final response = await client
        .from('saucer')
        .update({
          'name_saucer': nameSaucer,
          'name_drink': nameDrink,
          'schedule_id': scheduleId,
          'update_at': updateAt,
        })
        .eq('id', saucerId)
        .select('''*,schedule(*)''')
        .order('id', ascending: false)
        .limit(1)
        .single();
    return SaucerModel.fromJson(response);
  }

  @override
  Future<SaucerModel>? getSaucerById(int saucerId) async {
    final response = await client
        .from('saucer')
        .select('''*,schedule(*)''')
        .eq('id', saucerId)
        .limit(1)
        .single();
    return SaucerModel.fromJson(response);
  }

  @override
  Future<List<SaucerModel>>? getSaucersByScheduleId(
    int scheduleId,
    int from,
    int to,
  ) async {
    final response = await client
        .from('saucer')
        .select('''*,schedule(*)''')
        .eq('schedule_id', scheduleId)
        .range(from, to);
    return response.map((e) => SaucerModel.fromJson(e)).toList();
  }

  @override
  Future<bool>? addSaucerToGeneralOrder(
      int generalOrderId, int saucerId) async {
    final response = await client
        .from('general_order_saucers')
        .insert({
          'general_order_id': generalOrderId,
          'saucer_id': saucerId,
        })
        .select()
        .limit(1)
        .single();
    return response.isNotEmpty;
  }

  @override
  Future<GeneralOrderModel>? createGeneralOrder(
      String startDate, String endDate, String createdAt) async {
    final response = await client
        .from('general_order')
        .insert({
          'start_date': startDate,
          'end_date': endDate,
          'created_at': createdAt,
        })
        .select()
        .limit(1)
        .single();
    return GeneralOrderModel.fromJson(response);
  }

  @override
  Future<List<GeneralOrderModel>>? listGeneralOrders() async {
    final response = await client
        .from('general_order')
        .select('''*,saucers:general_order_saucers!inner(saucer(*,schedule(*)))''').order(
            'id',
            ascending: true);
    return response.map((e) => GeneralOrderModel.fromJson(e)).toList();
  }
}
