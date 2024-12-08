import 'package:flutter/material.dart';

class AssignAreaScreen extends StatelessWidget {
  static const routeName = 'assign_area_screen';
  const AssignAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar Área'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Un nuevo usuario desea registrarse'),
              const SizedBox(height: 8),
              const Text('Nombres'),
              const Text('Adan'),
              const SizedBox(height: 8),
              const Text('Apellidos'),
              const Text('Perez Gomez'),
              const SizedBox(height: 8),
              const Text('Genero'),
              const Text('Masculino'),
              const SizedBox(height: 8),
              const Text('Dirección'),
              const Text('Av. Los Pinos 123'),
              const SizedBox(height: 8),
              const Text('Teléfono'),
              const Text('957098212'),
              const SizedBox(height: 8),
              const Text('Correo'),
              const Text('email@gmai.com'),
              const SizedBox(height: 8),
              // Agregar un ListView para listar las áreas disponibles
              const Text('Área'),
              // Aquí se ajusta la altura del ListView
              SizedBox(
                height:
                    200, // O puedes cambiar el valor de height según el contenido
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: const Text('Área de trabajo'),
                      subtitle: const Text('Activo'),
                      trailing: const Icon(Icons.notifications_active_outlined),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
