import 'package:flutter/material.dart';

class ListTileUser extends StatelessWidget {
  const ListTileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Manuel Walter'),
          subtitle: const Text('Titular'),
          leading: const CircleAvatar(
            child: Text('M'),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
