import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/rrhh/presentation/widgets/card_area_work.dart';

import '../../../all_areas/presentation/screens/screens.dart';
import '../screens/screens.dart';

class HomeViewRRHH extends ConsumerWidget {
  static const String routeName = 'home_view_rrhh';
  final String typeUserId = '5';
  const HomeViewRRHH({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.grass_rounded,
                size: 30,
              ),
              TitleApp(
                text: 'Área RRHH',
                textAlign: TextAlign.start,
              ),
            ],
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
          titleCard: 'Registros de usuario',
          subTitleCard: 'Notificaciones de registros de usuario e historial',
          buttons: [
            ButtonDirectionScreen(
              title: 'Notificaciones',
              routeName: NotificationsOfRegisterScreen.routeName,
              icon: Icons.notifications_active,
            ),
            ButtonDirectionScreen(
              title: 'Historial',
              routeName: HistorialNotificationsScreen.routeName,
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
              return CardAreaWork(
                idArea: 'idAre$index',
                nameArea: 'nameArea',
                statusArea: 'pendiente',
                numberArea: 1,
                notificationsArea: 10,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        // Lista de usuarios
        DividerSection(
          titleSection: 'Mi Área',
          routeOfSection: MyAreaScreen.routeName,
          outlinedButtonIcon: OutlinedButton.icon(
            onPressed: () async {
              try {
                final file = await ref.read(
                  generateAttendancePdfProvider(
                    int.parse(typeUserId),
                  ).future,
                );
                SaveAndOpenDocument().openPdf(
                  file: file,
                );
              } catch (error) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(error.toString()),
                    );
                  },
                );
              }
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Generar'),
          ),
          params: {
            'my_area_type_user_id': typeUserId,
          },
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: MyAreaView(
            typeUserId: int.parse(typeUserId),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
