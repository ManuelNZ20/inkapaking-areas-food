import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class RequestNewUser extends ConsumerWidget {
  static const routeName = 'request_new_user_screen';
  const RequestNewUser({
    super.key,
    required this.userId,
  });
  final int userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataUserProvider(userId));
    // Aplicar gestor de estado para contener la información del usuario

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de nuevo usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: data.when(
          data: (data) {
            return DataUser(
              userId: data.userId,
              name: data.name,
              lastName: data.lastName,
              gender: data.gender,
              direction: data.address,
              phone: data.phone,
              email: data.email,
            );
          },
          error: (error, _) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
