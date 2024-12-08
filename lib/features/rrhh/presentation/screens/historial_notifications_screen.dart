import 'package:flutter/material.dart';

class HistorialNotificationsScreen extends StatelessWidget {
  static const routeName = 'historial_notifications_screen';
  const HistorialNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de notificaciones'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Solicitud aceptada'),
                  subtitle: const Text('2021-09-20 12:00:00'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Detalles de la solicitud'),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('Nombre: Adan Perez Gomez'),
                                  subtitle: Text('Correo: example@gmail.com'),
                                ),
                                ListTile(
                                  title: Text('Fecha de solicitud: 2021-09-20'),
                                  subtitle: Text('Hora de solicitud: 12:00:00'),
                                ),
                                ListTile(
                                  title: Text('Estado: Aceptado'),
                                  subtitle:
                                      Text('Fecha de aceptación: 2021-09-20'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            );
          }),
    );
  }
}
