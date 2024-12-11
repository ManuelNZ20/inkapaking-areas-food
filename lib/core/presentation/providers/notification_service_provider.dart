import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/services.dart';

final notificationServiceProvider = Provider<LocalNotificationService>((ref) {
  final service = LocalNotificationService();
  return service;
});
