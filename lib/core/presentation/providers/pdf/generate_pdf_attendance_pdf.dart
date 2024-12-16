import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/core/services/services.dart';

import '../../../../features/all_areas/presentation/providers/providers.dart';

final generateAttendancePdfProvider =
    FutureProvider.family<File, int>((ref, typeUserId) {
  final users = ref.watch(usersNotifierProvider(typeUserId));
  if (users.users == null || users.users!.isEmpty) {
    throw Exception('No se encontraron usuarios.');
  }

  final pdf = AttendanceMyAreaUsers().generatePdf(
    users: users.users!,
    nameArea: users.users!.first.typeName,
  );
  return pdf;
});
