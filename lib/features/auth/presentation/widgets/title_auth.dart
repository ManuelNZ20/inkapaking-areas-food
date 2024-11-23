import 'package:flutter/material.dart';

class TitleAuth extends StatelessWidget {
  const TitleAuth({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          // tamaño de letra que se ajusta al tamaño de la pantalla
          fontSize: MediaQuery.of(context).size.width * 0.06,
          letterSpacing: 1.5,
        );
    return Text(
      text,
      style: styleTitle,
      textAlign: TextAlign.center,
    );
  }
}
