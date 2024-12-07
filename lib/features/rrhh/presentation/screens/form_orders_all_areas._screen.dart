import 'package:flutter/material.dart';

import '../../../auth/presentation/widgets/widgets.dart';

class FormOrderAllAreasScreen extends StatelessWidget {
  static const String routeName = 'form_order_all_areas_screen';
  const FormOrderAllAreasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Crear un área',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: CustomTextField(
            label: 'Área',
            hint: 'Ingrese el nombre del área',
            onChanged: (value) {},
            errorMessage: '',
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.create),
          label: const Text('Crear una área'),
        ),
      ],
    );
  }
}
