import 'package:flutter/material.dart';

import '../title_view.dart';

class HeaderWithIcon extends StatelessWidget {
  const HeaderWithIcon({
    super.key,
    required this.titleArea,
    required this.icon,
  });
  final String titleArea;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final colorIcon = Theme.of(context).colorScheme.onPrimaryContainer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 24,
            color: colorIcon,
          ),
          TitleApp(
            text: titleArea,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
