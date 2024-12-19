import 'package:flutter/material.dart';

import '../../../all_areas/presentation/views/views.dart';
import '../../../auth/domain/domain.dart';
import '../../../dining_room/presentation/views/views.dart';
import '../../../rrhh/presentation/views/views.dart';
import '../screens/views/views.dart';

class HomeViewSelector extends StatelessWidget {
  const HomeViewSelector({
    super.key,
    required this.user,
  });
  final User? user;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    switch (user!.typeUser.id) {
      case 5: // Usuario RRHH
        return HomeViewRRHH(
          user: user!,
        );
      case 6: // Usuario Comedor
        return HomeViewDiningRoom(
          user: user!,
        );
      case 1: // Usuario no registrado
        return const UnLoggedView();
      default:
        return HomeViewAllAreas(user: user!);
    }
  }
}
