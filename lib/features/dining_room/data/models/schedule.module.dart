import '../../domain/domain.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.scheduleId,
    required super.name,
    required super.createdAt,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheduleId: json['id'] ?? 0,
      name: json['name_schedule'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
