import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';
import 'screens.dart';

class NotificationsOfRegisterScreen extends ConsumerWidget {
  static const routeName = 'notifications_register_screen';
  const NotificationsOfRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          },
          error: (error, _) => Text('Error: $error'),
          loading: () => const _LoadingNotifications(),
        ),
      ),
    );
  }
}

class _LoadingNotifications extends StatelessWidget {
  const _LoadingNotifications();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        SizedBox(height: 20),
        Text('Cargando datos...'),
      ],
    );
  }
}
