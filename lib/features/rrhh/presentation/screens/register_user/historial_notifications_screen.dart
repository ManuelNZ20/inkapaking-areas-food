import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inkapaking/features/rrhh/presentation/screens/screens.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HistorialNotificationsScreen extends ConsumerWidget {
  static const routeName = 'historial_notifications_screen';
  const HistorialNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifications = ref.watch(getAcceptedRequestsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de notificaciones'),
      ),
      body: listNotifications.when(
        data: (data) {
          if (data.isEmpty) {
            return const Text('No hay notificaciones');
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final notification = data[index];
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Solicitud aceptada'),
                    subtitle: Text(notification.dateAcceptRequest),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => context.pushNamed(
                          DetailUserScreen.routeName,
                          pathParameters: {
                            'detail_user_id': notification.userId.toString()
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
    );
  }
}
