import 'package:flutter/material.dart';

class ListTileUser extends StatelessWidget {
  const ListTileUser({
    super.key,
    required this.nameUser,
    required this.typeUser,
  });
  final String nameUser;
  final String typeUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(nameUser),
          subtitle: Text(typeUser),
          leading: CircleAvatar(
            child: Text(nameUser.characters.first),
          ),
          trailing: typeUser == '1'
              ? null
              : IconButton(
                  icon: const Icon(Icons.notifications_active_outlined),
                  onPressed: () {},
                ),
        ),
        const Divider(),
      ],
    );
  }
}
