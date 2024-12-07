import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Información'),
        content: const Text(
            'Al solicitar el registro, aceptas los términos y condiciones de uso de la aplicación.'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
