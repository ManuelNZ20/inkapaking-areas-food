import 'package:flutter/material.dart';

class LoadingViewNotifications extends StatelessWidget {
  const LoadingViewNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        SizedBox(height: 20),
        Text('Cargando datos...'),
      ],
    );
  }
}
