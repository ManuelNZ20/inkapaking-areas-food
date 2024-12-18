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

  factory GeneralOrderModel.fromJson(Map<String, dynamic> json) =>
      GeneralOrderModel(
        generalOrderId: json['id'],
        startDate: json['start_dat'],
        endDate: json['end_date'],
        createdAt: json['created_at'],
        saucers: (json['saucers'] ?? [])
            .map((e) => SaucerModel.fromJson(e))
            .toList(),
      );
}
