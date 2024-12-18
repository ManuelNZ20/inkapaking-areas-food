import 'package:equatable/equatable.dart';

import '../domain.dart';

class GeneralOrderSaucers extends Equatable {
  final GeneralOrder generalOrder;
  final List<Saucer> saucers;

  const GeneralOrderSaucers({
    required this.generalOrder,
    required this.saucers,
  });

  @override
  List<Object?> get props => [
        generalOrder,
        saucers,
      ];
}
