import 'package:equatable/equatable.dart';
import 'package:inkapaking/features/dining_room/domain/entities/schedule.dart';

class Saucer extends Equatable {
  final int saucerId;
  final String nameSaucer;
  final String nameDrink;
  final int scheduleId;
  final Schedule? schedule;
  final String createdAt;
  final String updateAt;

  const Saucer({
    required this.saucerId,
    required this.nameSaucer,
    required this.nameDrink,
    required this.scheduleId,
    this.schedule,
    required this.createdAt,
    required this.updateAt,
  });

  @override
  List<Object?> get props => [
        saucerId,
        nameSaucer,
        nameDrink,
        scheduleId,
        schedule,
        createdAt,
        updateAt,
      ];
}
