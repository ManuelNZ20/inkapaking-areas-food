import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonDirectionScreen extends StatelessWidget {
  ButtonDirectionScreen({
    super.key,
    this.title,
    this.routeName,
    this.icon,
  }) : assert(
          routeName != null && !routeName.startsWith('/'),
          'The path name should not start with /',
        );
  final String? title;
  final String? routeName;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        icon: Icon(icon ?? Icons.info),
        label: Text(title ?? 'Acción'),
        onPressed: () => routeName!.isNotEmpty ? context.go(routeName!) : null);
  }
}
