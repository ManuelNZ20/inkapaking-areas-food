import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkapaking/core/core.dart';
import 'package:inkapaking/features/rrhh/presentation/widgets/card_area_work.dart';

import '../../../home/presentation/screens/screens.dart';
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
        const HeaderWithIcon(
          titleArea: 'RRHH',
          icon: Icons.groups,
        ),
        const SizedBox(height: 20),
        CardDsh(
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
        // Ordenes por área
        DividerSection(
          titleSection: 'Ordenes por Área',
          routeOfSection: OrdersAllAreasScreen.routeName,
          iconButton: IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.picture_as_pdf),
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
