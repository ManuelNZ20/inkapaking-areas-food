import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/core.dart';
import '../../../../all_areas/presentation/screens/screens.dart';
import '../../../../auth/domain/domain.dart';
import '../../../../home/presentation/screens/views/views.dart';
import '../../providers/providers.dart';
import '../../screens/screens.dart';

class HomeViewDiningRoom extends ConsumerWidget {
  static const String routeName = 'home_view_dining_room';
  const HomeViewDiningRoom({
    super.key,
    required this.user,
  });

  final User user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalOrderToday = ref.watch(todayStreamProvider);
    return Column(
      children: [
        const SizedBox(height: 20),
        const HeaderWithIcon(
          titleArea: 'Comedor',
          icon: FontAwesomeIcons.plateWheat,
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
          icon: FontAwesomeIcons.layerGroup,
          titleCard: 'Ordenes generales del comedor',
          subTitleCard: 'Crear y ver ordenes',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Crear',
              routeName: NewGeneralOrderScreen.routeName,
              icon: Icons.create,
            ),
            DirectionButtonToAScreen(
              title: 'Mi historial',
              routeName: HistorialGeneralOrderScreen.routeName,
              icon: Icons.history,
            ),
          ],
        ),
        CardDsh(
          icon: FontAwesomeIcons.bowlRice,
          titleCard: 'Platillos',
          subTitleCard: 'Crear y lista de platillos',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Crear',
              routeName: SaucerFormScreen.routeName,
              pathParameters: const {
                'new_saucer_id': '0',
              },
              icon: Icons.create,
            ),
            DirectionButtonToAScreen(
              title: 'Lista de platillos',
              routeName: HistorialSaucerScreen.routeName,
              icon: Icons.restaurant_menu_rounded,
            ),
          ],
        ),
        CardDsh(
          icon: FontAwesomeIcons.bowlFood,
          titleCard: 'Mis Ordenes',
          subTitleCard: 'Crear y ver ordenes',
          buttonsDirection: [
            DirectionButtonToAScreen(
              title: 'Crear',
              routeName: MyOrderScreen.routeName,
              pathParameters: {
                'my_order_user_id': user.userId.toString(),
              },
              icon: Icons.create,
            ),
            DirectionButtonToAScreen(
              title: 'Mi historial',
              routeName: HistorialMyOrdersScreen.routeName,
              icon: Icons.history,
              pathParameters: {
                'historial_my_order_user_id': user.userId.toString(),
              },
            ),
          ],
        ),
        MyAreaPrintPdfDivider(typeUserId: '${user.typeUser.id}'),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: MyAreaView(
            typeUserId: int.parse('${user.typeUser.id}'),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
