import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class DetailUserScreen extends ConsumerWidget {
  static const String routeName = 'detail_user_screen';
  const DetailUserScreen({
    super.key,
    required this.userUserId,
  });
  final int userUserId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataUserProvider(userUserId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de usuario'),
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
              typeUserName: data.typeUser.typeName,
            );
          },
          error: (error, _) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const LoadingViewNotifications();
          },
        ),
      ),
    );
  }
}
