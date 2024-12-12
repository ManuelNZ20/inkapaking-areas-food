import 'package:flutter/material.dart';

class SelectedGender extends StatelessWidget {
  const SelectedGender({
    super.key,
    this.onChanged,
    this.initValue,
  }) : assert(
          initValue == null || initValue == 'M' || initValue == 'F',
          'initValue must be M or F',
        );
  final Function(String)? onChanged;
  final String? initValue;
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
      value: initValue ?? 'M',
      items: const [
        DropdownMenuItem(
          value: 'M',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: 'F',
          child: Text('Femenino'),
        ),
      ],
      onChanged: (value) {
        onChanged!(value.toString());
      },
    );
  }
}
