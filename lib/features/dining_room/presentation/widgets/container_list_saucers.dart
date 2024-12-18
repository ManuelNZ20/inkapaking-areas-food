import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class ContainerListSaucers extends StatelessWidget {
  const ContainerListSaucers({
    super.key,
    required this.saucers,
  });

  final List<Saucer> saucers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        itemCount: saucers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final saucer = saucers[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 10),
                    Text(saucer.schedule!.name),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .92,
                  height: MediaQuery.of(context).size.height * .1,
                  child: ListTile(
                    title: Text(
                      saucer.nameSaucer,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      saucer.nameDrink,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
