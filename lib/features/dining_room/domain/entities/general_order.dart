import 'package:equatable/equatable.dart';

import 'saucer.dart';

class GeneralOrder extends Equatable {
  final int generalOrderId;
  final String startDate;
  final String endDate;
  final String createdAt;
  final List<Saucer>? saucers;
  const GeneralOrder({
    required this.generalOrderId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.saucers,
  });
  @override
  List<Object?> get props => [
        generalOrderId,
        startDate,
        endDate,
        createdAt,
        saucers,
      ];
}
