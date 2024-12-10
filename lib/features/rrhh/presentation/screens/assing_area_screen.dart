import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inkapaking/core/core.dart';

import '../providers/providers.dart';

class AssignAreaScreen extends ConsumerStatefulWidget {
  static const routeName = 'assign_area_screen';
  const AssignAreaScreen({
    super.key,
    required this.userId,
  });

  final int userId;
  @override
  ConsumerState<AssignAreaScreen> createState() => _AssignAreaScreenState();
}

class _AssignAreaScreenState extends ConsumerState<AssignAreaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(assignAreaFormProvider.notifier).loadTypeUsers(
            widget.userId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final typeUsersState = ref.watch(assignAreaFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar Área'),
      ),
      body: typeUsersState.isLoading == true
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey,
                  ),
                  subtitle: Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey,
                  ),
                  trailing: const Icon(Icons.replay_rounded),
                );
              },
            )
          : const AssignArea(),
    );
  }
}

class AssignArea extends ConsumerWidget {
  const AssignArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeUsersState = ref.watch(assignAreaFormProvider);
    final value = typeUsersState.typeUserId!;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: typeUsersState.typeUsers!.length,
            itemBuilder: (context, index) {
              final typeUser = typeUsersState.typeUsers![index];
              if (typeUser.typeUserId == 1) return const SizedBox();
              return SizedBox(
                width: double.infinity,
                child: RadioListTile<int>(
                  title: Text(typeUser.typeName),
                  subtitle: Text(typeUser.description),
                  value: typeUser.typeUserId,
                  groupValue: value,
                  onChanged: (value) {
                    ref
                        .read(assignAreaFormProvider.notifier)
                        .onTypeUserChanged(value!);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () async {
              bool success = await ref
                  .read(assignAreaFormProvider.notifier)
                  .assignAreaNewUser(typeUsersState.typeUserId!);
              if (success) {
                // Mostrar un mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Área asignada exitosamente')),
                );

                // Navegar a otra pantalla (por ejemplo, "HomeScreen")
                context.goNamed(HomeScreen.routeName);
              } else {
                // Mostrar un mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al asignar el área')),
                );
              }
            },
            child: const Text('Asignar Área'),
          ),
        ),
      ],
    );
  }
}
