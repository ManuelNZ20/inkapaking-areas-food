import 'package:flutter/material.dart';
import '../../../widgets/widgets.dart';

class AreaScreen extends StatelessWidget {
  static const String routeName = 'area_screen';
  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Área'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return const SizedBox(
            width: double.infinity,
            child: ListTileUser(),
          );
        },
      ),
    );
  }
}
