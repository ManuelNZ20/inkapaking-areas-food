import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkapaking/core/core.dart';

import '../../../features/all_areas/presentation/screens/screens.dart';
import '../../../features/home/presentation/providers/providers.dart';

class MyAreaPrintPdfDivider extends ConsumerWidget {
  const MyAreaPrintPdfDivider({
    super.key,
    required this.typeUserId,
  });
  final String typeUserId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DividerSection(
      titleSection: 'Mi Área',
      routeOfSection: MyAreaScreen.routeName,
      iconButton: IconButton(
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
        icon: const FaIcon(FontAwesomeIcons.filePdf),
      ),
      params: {
        'my_area_type_user_id': typeUserId,
      },
    );
  }
}
