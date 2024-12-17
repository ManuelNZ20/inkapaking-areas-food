import 'package:flutter/material.dart';

class HistorialSaucerScreen extends StatelessWidget {
  static const String routeName = 'historial_saucer_screen';
  const HistorialSaucerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de platillos'),
      ),
      body: const Center(
        child: Text('Historial de platillos'),
      ),
    );
  }
}
