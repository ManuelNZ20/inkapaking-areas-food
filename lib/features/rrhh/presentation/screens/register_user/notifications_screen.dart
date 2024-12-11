import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../providers/providers.dart';
import '../screens.dart';

class NotificationsOfRegisterScreen extends ConsumerStatefulWidget {
  static const routeName = 'notifications_register_screen';
  const NotificationsOfRegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsOfRegisterScreenState();
}

class _NotificationsOfRegisterScreenState
    extends ConsumerState<NotificationsOfRegisterScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(getRequestUserProvider);
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(getRequestUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes Pendientes'),
      ),
      body: Center(
        child: data.when(
          data: (users) {
            if (users.isEmpty) {
              return const Text('No hay solicitudes pendientes');
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Solicitud de nuevo usuario'),
                      subtitle: Text(user.createdAt),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => context.pushNamed(
                            RequestNewUser.routeName,
                            pathParameters: {
                              'request_user_id': user.userId.toString(),
                            }),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          },
          error: (error, _) => Text('Error: $error'),
          loading: () => const LoadingViewNotifications(),
        ),
      ),
    );
  }
}
