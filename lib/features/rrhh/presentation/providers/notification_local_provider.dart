import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final userNotifierProvider = Provider<UserNotifier>((ref) {
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
        print('Users: $users');
        if (isFirstLoad) {
          isFirstLoad = false;
          return;
        }
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
      title: 'Nuevo usuario registrado',
      body: 'Se ha registrado un nuevo usuario Id ${newUser.userId}',
      payload: '/home/notifications_register',
    );
  }
}
