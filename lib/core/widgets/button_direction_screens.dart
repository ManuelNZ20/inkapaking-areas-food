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
    final styleTitle = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          color: Theme.of(context).scaffoldBackgroundColor,
          letterSpacing: 1.3,
        );
    return TextButton.icon(
        icon: Icon(
          icon ?? Icons.info,
          color: Colors.white,
        ),
        label: Text(
          title ?? 'Acción',
          style: styleTitle,
        ),
        onPressed: () =>
            routeName!.isNotEmpty ? context.pushNamed(routeName!) : null);
  }
}
