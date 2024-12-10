import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

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
                    subtitle: Text(notification.createdAt),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
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
