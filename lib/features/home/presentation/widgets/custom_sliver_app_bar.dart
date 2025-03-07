import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inkapaking/core/constants/list_images.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../../../config/presentation/screens/screens.dart';

class CustomSliverAppBar extends ConsumerWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider);
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.2,
      foregroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          'Bienvenido a \nINKAPAKING S.A.C',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        background: Stack(
          children: [
            const SizedBox.expand(
              child: _ImageBackground(),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
            Positioned(
              right: 10,
              top: 20,
              child: IconButton.filledTonal(
                onPressed: authNotifier.user != null
                    ? () => context.pushNamed(
                          ConfigProfileScreen.routeName,
                          pathParameters: {
                            'config_user_id':
                                authNotifier.user!.userId.toString(),
                          },
                        )
                    : null,
                // context.pushNamed(
                //   ConfigProfileScreen.routeName,
                // )
                icon: authNotifier.user == null
                    ? const Icon(Icons.replay_outlined)
                    : const Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageBackground extends StatelessWidget {
  const _ImageBackground();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      listImagesHome[Random().nextInt(listImagesHome.length)],
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: frame == null ? 0 : 1,
          child: child,
        );
      },
    );
  }
}
