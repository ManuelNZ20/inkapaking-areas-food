import '../../domain/domain.dart';
import 'saucer.module.dart';

class GeneralOrderModel extends GeneralOrder {
  const GeneralOrderModel({
    required super.generalOrderId,
    required super.startDate,
    required super.endDate,
    required super.createdAt,
    super.saucers,
  });

  factory GeneralOrderModel.fromJson(Map<String, dynamic> json) {
    return GeneralOrderModel(
      generalOrderId: json['id'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      createdAt: json['created_at'] ?? '',
      saucers: (json['saucers'] as List<dynamic>?)
          ?.map((e) => SaucerModel.fromJson(e['saucer']))
          .toList(),
    );
  }
}
