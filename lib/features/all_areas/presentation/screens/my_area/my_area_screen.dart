import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/core.dart';
import '../../providers/providers.dart';

class MyAreaScreen extends StatelessWidget {
  static const String routeName = 'my_area_screen';
  const MyAreaScreen({
    super.key,
    required this.typeUserId,
  });
  final int typeUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Área $typeUserId'),
      ),
      body: _MyAreaView(
        typeUserId: typeUserId,
      ),
    );
  }
}

class _MyAreaView extends ConsumerWidget {
  const _MyAreaView({
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
