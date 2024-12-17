import 'package:flutter/material.dart';

class NewGeneralOrderScreen extends StatelessWidget {
  static const String routeName = 'new_general_order_screen';
  const NewGeneralOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orden general'),
      ),
      body: const Center(
        child: Text('Orden general'),
      ),
    );
  }
}
