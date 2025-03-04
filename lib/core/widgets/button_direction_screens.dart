import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DirectionButtonToAScreen extends StatelessWidget {
  DirectionButtonToAScreen({
    super.key,
    this.title,
    this.routeName,
    this.icon,
    this.pathParameters,
  }) : assert(
          routeName != null && !routeName.startsWith('/'),
          'The path name should not start with /',
        );
  final String? title;
  final String? routeName;
  final IconData? icon;
  final Map<String, String>? pathParameters;
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
        onPressed: () => routeName!.isNotEmpty
            ? pathParameters != null
                ? context.pushNamed(
                    routeName!,
                    pathParameters: pathParameters!,
                  )
                : context.pushNamed(
                    routeName!,
                  )
            : null);
  }
}
