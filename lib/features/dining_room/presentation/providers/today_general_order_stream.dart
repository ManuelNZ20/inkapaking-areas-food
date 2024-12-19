import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/features/dining_room/data/data.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final todayStreamProvider = StreamProvider<GeneralOrder?>((ref) async* {
  final client = Supabase.instance.client;
  final date =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
  final response = client
      .from('general_order')
      .stream(primaryKey: ['id'])
      .eq('created_at', date)
      .order('created_at', ascending: true);
  final result = response.map(
    (event) {
      if (event.isEmpty) {
        return null;
      }
      return GeneralOrderModel.fromJson(event.first);
    },
  );
  yield* result;
});
final todayGeneralOrderStreamProvider =
    StreamProvider<Either<Failure, GeneralOrder>>(
  (ref) async* {
    final getTodayGeneralOrderStream =
        ref.read(getTodayGeneralOrderStreamUseCaseProvider);
    final createAt =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc().toLocal());
    yield* getTodayGeneralOrderStream(
        GetLastGeneralOrderStreamParams(date: createAt));
  },
);

class TodayGeneralOrderNotifier extends StateNotifier<TodayGeneralOrderState> {
  GetTodayGeneralOrder getTodayGeneralOrder;
  TodayGeneralOrderNotifier({
    required this.getTodayGeneralOrder,
  }) : super(TodayGeneralOrderState());
}

class TodayGeneralOrderState {
  final GeneralOrder? generalOrder;
  final bool hasGeneralOrder;
  final String createdAt;
  final bool isPosting;
  final String errorMessage;

  TodayGeneralOrderState({
    this.generalOrder,
    this.hasGeneralOrder = false,
    this.createdAt = '',
    this.isPosting = false,
    this.errorMessage = '',
  });

  TodayGeneralOrderState copyWith({
    GeneralOrder? generalOrder,
    bool? hasGeneralOrder,
    String? createdAt,
    bool? isPosting,
    String? errorMessage,
  }) {
    return TodayGeneralOrderState(
      generalOrder: generalOrder ?? this.generalOrder,
      hasGeneralOrder: hasGeneralOrder ?? this.hasGeneralOrder,
      createdAt: createdAt ?? this.createdAt,
      isPosting: isPosting ?? this.isPosting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
