import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonAuth extends StatelessWidget {
  const BackButtonAuth({
    super.key,
    required this.textButton,
  });
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: context.pop,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      child: Text(textButton),
    );
  }
}
