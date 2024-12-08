import 'package:flutter/material.dart';
import 'package:inkapaking/core/core.dart';

import '../../../../core/widgets/widgets.dart';
import '../screens/screens.dart';

class HomeViewRRHH extends StatelessWidget {
  const HomeViewRRHH({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TitleApp(
            text: 'Área RRHH\nBienvenido INKAPAKING S.A.C',
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 20),
        CardDsh(
          titleCard: 'Mis Ordenes',
          subTitleCard: 'Crear y ver ordenes',
          buttons: [
            ButtonDirectionScreen(
              title: 'Crear',
              routeName: '',
              icon: Icons.create,
            ),
            ButtonDirectionScreen(
              title: 'Mi historial',
              routeName: '',
              icon: Icons.history,
            ),
          ],
        ),
        CardDsh(
          titleCard: 'Ordenes del día para el personal',
          subTitleCard: 'Crear y ver ordenes del día para el personal',
          buttons: [
            ButtonDirectionScreen(
              title: 'Crear',
              routeName: '',
              icon: Icons.create,
            ),
            ButtonDirectionScreen(
              title: 'Historial',
              routeName: '',
              icon: Icons.history,
            ),
          ],
        ),
        CardDsh(
          titleCard: 'Registros de usuario',
          subTitleCard: 'Notificaciones de registros de usuario e historial',
          buttons: [
            ButtonDirectionScreen(
              title: 'Notificaciones',
              routeName: '',
              icon: Icons.notifications_active,
            ),
            ButtonDirectionScreen(
              title: 'Historial',
              routeName: '',
              icon: Icons.history,
            ),
          ],
        ),
        // Ordenes por área
        DividerSection(
          titleSection: 'Ordenes por Área',
          routeOfSection: OrdersAllAreasScreen.routeName,
          outlinedButtonIcon: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Generar'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
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
                              icon:
                                  const Icon(Icons.circle_notifications_sharp),
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
        ),
        const SizedBox(height: 10),
        // Lista de usuarios
        DividerSection(
          titleSection: 'Mi Área',
          routeOfSection: AreaScreen.routeName,
          outlinedButtonIcon: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Generar'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const SizedBox(
                width: double.infinity,
                child: ListTileUser(),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
