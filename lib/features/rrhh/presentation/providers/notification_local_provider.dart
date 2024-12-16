import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final userNotificationProvider = Provider<UserNotifier>((ref) {
  // final notificationService = ref.watch(notificationServiceProvider);
  final getRequestUser = ref.watch(getRequestUserProvider);
  return UserNotifier(
    ref,
    // notificationService,
    getRequestUser,
  );
});

class UserNotifier {
  final Ref ref;
  // final LocalNotificationService notificationService;
  final AsyncValue<List<RequestUser>> getRequestUser;
  bool isFirstLoad = true;

  UserNotifier(
    this.ref,
    // this.notificationService,
    this.getRequestUser,
  ) {
    LocalNotificationService.init();
  }

  void checkNewRequestUser() {
    getRequestUser.when(
      data: (users) {
        print('users: $users');
        if (users.isNotEmpty) {
          final newUser = users.last;
          _sendNotification(newUser);
        }
      },
      error: (error, _) {},
      loading: () {},
    );
  }

  void _sendNotification(RequestUser newUser) {
    LocalNotificationService.show(
      id: newUser.userId,
      title: 'Nuevos usuarios',
      body: 'Se ha registrado una nueva solicitud de usuario',
      payload: '/home/notifications_register',
    );
  }
}
