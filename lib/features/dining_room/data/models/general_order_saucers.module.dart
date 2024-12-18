import '../../domain/domain.dart';
import '../data.dart';

class GeneralOrderSaucersModel extends GeneralOrderSaucers {
  const GeneralOrderSaucersModel({
    required super.generalOrder,
    required super.saucers,
  });

  factory GeneralOrderSaucersModel.fromJson(Map<String, dynamic> json) =>
      GeneralOrderSaucersModel(
        generalOrder: GeneralOrderModel.fromJson(json['general_order']),
        saucers: (json['saucers'] as List)
            .map((e) => SaucerModel.fromJson(e))
            .toList(),
      );
}
