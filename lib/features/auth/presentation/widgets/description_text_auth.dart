import 'package:flutter/material.dart';

class DescriptionTextAuth extends StatelessWidget {
  const DescriptionTextAuth({
    super.key,
    required this.description,
    horizontalPadding,
    verticalPadding,
    colorsTextStyle,
    heightStyleText,
    textAlign,
  })  : hPaddingDesc = horizontalPadding ?? 20.0,
        vPaddingDesc = verticalPadding ?? 0.0,
        colorsText =
            colorsTextStyle ?? const Color.fromARGB(255, 156, 155, 155),
        heightStyle = heightStyleText ?? 1.5,
        textAlignDescription = textAlign ?? TextAlign.justify;
  final String description;
  final double? hPaddingDesc;
  final double? vPaddingDesc;
  final Color? colorsText;
  final double? heightStyle;
  final TextAlign? textAlignDescription;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorsText,
          height: heightStyle,
        );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: hPaddingDesc!,
        vertical: vPaddingDesc ?? 0,
      ),
      child: Text(
        description,
        style: textStyle,
        textAlign: textAlignDescription,
      ),
    );
  }
}
