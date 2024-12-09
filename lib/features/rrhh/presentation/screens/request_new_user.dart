import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens.dart';

class RequestNewUser extends StatelessWidget {
  final String name = "Adan";
  final String lastName = "Perez Gomez";
  final String genero = "Masculino";
  final String direccion = 'Av. Los Pinos 123';
  final String phone = "957098212";
  final String email = "adan.perez@example.com";

  static const routeName = 'request_new_user_screen';
  const RequestNewUser({
    super.key,
    required this.userId,
  });
  final int userId;
  @override
  Widget build(BuildContext context) {
    // Aplicar gestor de estado para contener la información del usuario
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitud de nuevo usuario $userId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Un nuevo usuario desea registrarse en la aplicación',
                style: titleScreen,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
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
              Text(genero),
              const SizedBox(height: 10),
              Text(
                'Dirección',
                style: title,
              ),
              Text(direccion),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        context.pushNamed(AssignAreaScreen.routeName),
                    child: const Text('Asignar Área'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Denegar Registro'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
