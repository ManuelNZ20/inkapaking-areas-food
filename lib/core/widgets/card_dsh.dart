import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inkapaking/core/constants/list_images.dart';

class CardDsh extends StatelessWidget {
  const CardDsh({
    super.key,
    required this.titleCard,
    required this.subTitleCard,
    this.buttons,
  }) : assert(
          buttons == null || buttons.length <= 3,
          'El número máximo de botones es 3',
        );
  final String titleCard;
  final String subTitleCard;
  final List<Widget>? buttons;

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.04,
          letterSpacing: 1.3,
        );
    final subTitle = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          letterSpacing: 1.3,
        );
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Image.asset(
              listImagesRandom[Random().nextInt(listImagesRandom.length)],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                // Animación de opacidad
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: frame == null ? 0 : 1,
                  child: child,
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Texto en la parte superior
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleCard,
                      style: title,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subTitleCard,
                      style: subTitle,
                    ),
                  ],
                ),
              ),
              // Botones en la parte inferior
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: buttons ?? [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
