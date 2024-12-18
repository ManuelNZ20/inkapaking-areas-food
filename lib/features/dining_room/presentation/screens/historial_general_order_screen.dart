import 'package:flutter/material.dart';

class HistorialGeneralOrderScreen extends StatelessWidget {
  static const String routeName = 'historial_general_order_screen';
  const HistorialGeneralOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: const Center(
        child: Text('Historial de ordenes generales'),
      ),
    );
  }
}
