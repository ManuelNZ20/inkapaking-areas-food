import 'package:flutter/material.dart';

class UnLoggedView extends StatelessWidget {
  const UnLoggedView({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.bodyLarge;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            Text(
              'Usuario sin registrar',
              style: title,
            ),
            const SizedBox(height: 20),
            Text(
              'Por favor, comuníquese con el administrador.',
              style: title,
            ),
          ],
        ),
      ),
    );
  }
}
