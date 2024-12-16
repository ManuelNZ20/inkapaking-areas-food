import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/core.dart';
import '../../../../all_areas/presentation/providers/providers.dart';

class MyAreaView extends ConsumerWidget {
  const MyAreaView({
    super.key,
    required this.typeUserId,
  });
  final int typeUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersNotifierProvider(typeUserId));
    return users.isLoading!
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : users.users!.isEmpty
            ? const Center(
                child: Text('No hay usuarios'),
              )
            : ListView.builder(
                itemCount: users.users!.length,
                itemBuilder: (context, index) {
                  final user = users.users![index];
                  return ListTileUser(
                    nameUser: user.name,
                    typeUser: user.typeName,
                  );
                },
              );
  }
}
