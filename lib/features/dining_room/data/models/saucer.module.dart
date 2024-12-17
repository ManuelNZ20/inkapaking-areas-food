import '../../domain/domain.dart';
import 'schedule.module.dart';

class SaucerModel extends Saucer {
  const SaucerModel({
    required super.saucerId,
    required super.nameSaucer,
    required super.nameDrink,
    required super.scheduleId,
    required super.schedule,
    required super.createdAt,
    required super.updateAt,
  });

  factory SaucerModel.fromJson(Map<String, dynamic> json) {
    return SaucerModel(
      saucerId: json['id'] ?? 0,
      nameSaucer: json['name_saucer'] ?? '',
      nameDrink: json['name_drink'] ?? '',
      scheduleId: json['schedule_id'] ?? 0,
      schedule: ScheduleModel.fromJson(json['schedule'] ?? {}),
      createdAt: json['created_at'] ?? '',
      updateAt: json['update_at'] ?? '',
    );
  }
}
