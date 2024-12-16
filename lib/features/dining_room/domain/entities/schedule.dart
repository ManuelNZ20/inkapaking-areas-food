import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int scheduleId;
  final String name;
  final String createdAt;

  const Schedule({
    required this.scheduleId,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        scheduleId,
        name,
        createdAt,
      ];
}
