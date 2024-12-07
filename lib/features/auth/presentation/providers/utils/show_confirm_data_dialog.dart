import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers.dart';

void showConfirmDataDialog(BuildContext context, WidgetRef ref) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirmar datos'),
        content: const Text(
            'Al solicitar el registro, aceptas los términos y condiciones de uso de la aplicación.'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(registerFormProvider.notifier).onFormSubmit();
              context.go('/home');
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
