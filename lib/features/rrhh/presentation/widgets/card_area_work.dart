import 'package:flutter/material.dart';

class CardAreaWork extends StatelessWidget {
  const CardAreaWork({
    super.key,
    required this.idArea,
    required this.nameArea,
    required this.statusArea,
    required this.numberArea,
    required this.notificationsArea,
  });
  final String idArea;
  final String nameArea;
  final String statusArea;
  final int numberArea;
  final int notificationsArea;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.business_center_outlined),
                  Text(nameArea),
                  Chip(
                    label: Text(statusArea.toUpperCase()),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_outline),
                    label: Text('$numberArea'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.circle_notifications_sharp),
                    label: Text('$notificationsArea'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
