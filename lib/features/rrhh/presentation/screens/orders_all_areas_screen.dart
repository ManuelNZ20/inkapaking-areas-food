import 'package:flutter/material.dart';

class OrdersAllAreasScreen extends StatelessWidget {
  static const String routeName = 'orders_all_areas_screen';
  const OrdersAllAreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes de todas las áreas'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.business),
                        Text('Administración'),
                        Chip(label: Text('Pendiente')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person_outline),
                          label: const Text('10'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.circle_notifications_sharp),
                          label: const Text('4'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Crear una orden'),
                content: const Text('¿Desea crear una orden?'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Aceptar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
