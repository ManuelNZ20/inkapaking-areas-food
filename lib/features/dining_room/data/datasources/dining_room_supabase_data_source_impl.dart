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
}
