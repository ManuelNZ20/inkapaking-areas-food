import 'package:flutter/material.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({
    super.key,
    required this.text,
    textAlign,
  }) : align = textAlign ?? TextAlign.center;
  final String text;
  final TextAlign? align;
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
      textAlign: align,
    );
  }
}
