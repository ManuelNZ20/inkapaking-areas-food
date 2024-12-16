import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../auth/domain/domain.dart';

class HomeViewAllAreas extends StatelessWidget {
  const HomeViewAllAreas({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        HeaderWithIcon(
          titleArea: user.typeUser.typeName,
          icon: Icons.group_work_outlined,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
