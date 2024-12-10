import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/screens.dart';

class DataUser extends ConsumerWidget {
  const DataUser({
    super.key,
    required this.userId,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.direction,
    required this.phone,
    required this.email,
    this.typeUserName,
  });
  final int userId;
  final String name;
  final String lastName;
  final bool gender;
  final String direction;
  final String phone;
  final String email;
  final String? typeUserName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleScreen = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        );
    final title = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Theme.of(context).colorScheme.primary,
        );
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            typeUserName != null
                ? 'Detalles de usuario'
                : 'Solicitud de nuevo usuario',
            style: titleScreen,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            '#$userId',
            style: title,
          ),
          const SizedBox(height: 8),
          Text(
            'Nombres',
            style: title,
          ),
          Text(name),
          const SizedBox(height: 10),
          Text(
            'Apellidos',
            style: title,
          ),
          Text(lastName),
          const SizedBox(height: 10),
          Text(
            'Genero',
            style: title,
          ),
          Text(gender ? 'Masculino' : 'Femenino'),
          const SizedBox(height: 10),
          Text(
            'Dirección',
            style: title,
          ),
          Text(direction),
          const SizedBox(height: 10),
          Text(
            'Teléfono',
            style: title,
          ),
          Text(phone),
          const SizedBox(height: 10),
          Text(
            'Correo',
            style: title,
          ),
          Text(email),
          const SizedBox(height: 10),
          typeUserName != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Área',
                      style: title,
                    ),
                    Text(typeUserName!),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Aceptar solicitud'),
                              content: const Text(
                                  '¿Estás seguro de aceptar la solicitud?'),
                              actions: [
                                TextButton(
                                  onPressed: context.pop,
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                    context.pushNamed(
                                      AssignAreaScreen.routeName,
                                      pathParameters: {
                                        'request_user_id': userId.toString(),
                                        'assign_area_user_id':
                                            userId.toString(),
                                      },
                                    );
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Asignar Área'),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
