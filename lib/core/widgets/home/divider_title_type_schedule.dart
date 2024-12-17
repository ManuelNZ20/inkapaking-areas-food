import 'package:flutter/material.dart';

class DividerTitleTypeSchedule extends StatelessWidget {
  const DividerTitleTypeSchedule({
    super.key,
    required this.titleSchedule,
    required this.iconData,
  });
  final IconData iconData;
  final String titleSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              titleSchedule,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(iconData),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
