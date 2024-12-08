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
  const RequestNewUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de nuevo usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Un nuevo usuario desea registrarse'),
            const SizedBox(height: 8),
            const Text('Nombres'),
            Text(name),
            const SizedBox(height: 8),
            const Text('Apellidos'),
            Text(lastName),
            const SizedBox(height: 8),
            const Text('Genero'),
            Text(genero),
            const SizedBox(height: 8),
            const Text('Dirección'),
            Text(direccion),
            const SizedBox(height: 8),
            const Text('Teléfono'),
            Text(phone),
            const SizedBox(height: 8),
            const Text('Correo'),
            Text(email),
            const SizedBox(height: 8),
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
    );
  }
}
