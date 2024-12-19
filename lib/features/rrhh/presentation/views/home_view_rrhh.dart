import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkapaking/core/core.dart';

import '../../../dining_room/presentation/providers/providers.dart';
import '../../../home/presentation/screens/screens.dart';
import '../screens/screens.dart';

class HomeViewRRHH extends ConsumerWidget {
  static const String routeName = 'home_view_rrhh';
  final String typeUserId = '5';
  const HomeViewRRHH({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalOrderToday = ref.watch(todayStreamProvider);
    return Column(
      children: [
        const SizedBox(height: 20),
        const HeaderWithIcon(
          titleArea: 'RRHH',
          icon: Icons.groups,
        ),
        const SizedBox(height: 20),
        generalOrderToday.when(
          data: (data) {
            if (data == null) {
              return const Text('No hay ordenes para hoy');
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ListTile(
                  title: Text('Orden de hoy: ${data.createdAt}'),
                  subtitle:
                      Text('Inicio: ${data.startDate} - Fin: ${data.endDate}'),
                  leading: const Icon(FontAwesomeIcons.bullhorn),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stack) {
            return Text('Error: $error');
          },
          loading: () => const CircularProgressIndicator(),
        ),
        const SizedBox(height: 10),

        CardDsh(
          icon: FontAwesomeIcons.bowlFood,
          titleCard: 'Mis Ordenes',
          subTitleCard: 'Crear y ver ordenes',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Crear',
              routeName: '',
              icon: Icons.create,
            ),
            DirectionButtonToAScreen(
              title: 'Mi historial',
              routeName: '',
              icon: Icons.history,
            ),
          ],
        ),
        CardDsh(
          icon: FontAwesomeIcons.usersRays,
          titleCard: 'Registros de usuario',
          subTitleCard: 'Notificaciones de registros de usuario e historial',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Notificaciones',
              routeName: NotificationsOfRegisterScreen.routeName,
              icon: Icons.notifications_active,
            ),
            DirectionButtonToAScreen(
              title: 'Historial',
              routeName: HistorialNotificationsScreen.routeName,
              icon: Icons.history,
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Lista de usuarios
        MyAreaPrintPdfDivider(typeUserId: typeUserId),
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
