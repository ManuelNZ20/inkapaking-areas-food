import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/core.dart';
import '../../../../auth/domain/domain.dart';
import '../../../../dining_room/presentation/providers/providers.dart';
import '../../../../home/presentation/screens/views/views.dart';

class HomeViewAllAreas extends ConsumerWidget {
  const HomeViewAllAreas({
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
        HeaderWithIcon(
          titleArea: user.typeUser.typeName,
          icon: Icons.group_work_outlined,
        ),
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
