import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens.dart';

final client = Supabase.instance.client;
final usersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final users =
      await client.from('users').select('''''').eq('state_account', false);
  if (users.isEmpty) {
    throw Exception('No se encontraron usuarios');
  }
  return users;
});

class NotificationsOfRegisterScreen extends ConsumerWidget {
  static const routeName = 'notifications_register_screen';
  const NotificationsOfRegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.read(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes Pendientes'),
      ),
      body: Center(
        child: data.when(
          data: (users) {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Solicitud de nuevo usuario'),
                      subtitle: Text(
                          DateTime.parse(user['created_at'].toString())
                              .toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () =>
                            context.pushNamed(RequestNewUser.routeName),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          },
          error: (error, _) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
