import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../home/presentation/screens/views/views.dart';

class HomeViewDiningRoom extends ConsumerWidget {
  static const String routeName = 'home_view_dining_room';
  final String typeUserId = '5';
  const HomeViewDiningRoom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const HeaderWithIcon(
          titleArea: 'Comedor',
          icon: Icons.restaurant,
        ),
        const SizedBox(height: 20),
        CardDsh(
          titleCard: 'Ordenes generales del comedor',
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
          titleCard: 'Platillos',
          subTitleCard: 'Crear y lista de platillos',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Crear',
              routeName: '',
              icon: Icons.create,
            ),
            DirectionButtonToAScreen(
              title: 'Lista de platillos',
              routeName: '',
              icon: Icons.restaurant_menu_rounded,
            ),
          ],
        ),
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
