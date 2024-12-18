import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class DetailGeneralOrderWithSaucersScreen extends StatelessWidget {
  static const String routeName = 'detail_general_order_with_saucers_screen';
  const DetailGeneralOrderWithSaucersScreen({
    super.key,
    required this.saucers,
  });
  final List<Saucer> saucers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la orden'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: ListView.builder(
            itemCount: saucers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final saucer = saucers[index];
              return Column(
                children: [
                  Text('Horario: ${saucer.schedule!.name}'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .1,
                    child: ListTile(
                      title: Text(saucer.nameSaucer),
                      subtitle: Text(saucer.nameDrink),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
