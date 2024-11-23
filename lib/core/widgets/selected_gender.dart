import 'package:flutter/material.dart';

class SelectedGender extends StatelessWidget {
  const SelectedGender({super.key});

  @override
  Widget build(BuildContext context) {
    const border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1,
      ),
    );
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        labelText: 'Género',
        isDense: true,
      ),
      value: 'Masculino',
      items: const [
        DropdownMenuItem(
          value: 'Masculino',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: 'Femenino',
          child: Text('Femenino'),
        ),
      ],
      onChanged: (value) {},
    );
  }
}
