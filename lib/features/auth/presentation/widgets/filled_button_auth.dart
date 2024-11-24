import 'package:flutter/material.dart';

class FilledButtonAuth extends StatelessWidget {
  const FilledButtonAuth({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(title));
  }
}
