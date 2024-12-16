import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/helpers.dart';
import '../../providers/providers.dart';

import '../../../../auth/presentation/providers/providers.dart';
import '../../../../../core/core.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider);
    // Dentro de build()
    setupHomeListeners(context, ref, authNotifier);

    // Dentro de _setupListeners
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData((connectivityResult) async {
        await handleConnectivity(context, ref, connectivityResult);
      });
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          if (authNotifier.hasUser && authNotifier.user!.typeUser.id != 1)
            const CustomSliverAppBar(), // Ocultar si el usuario es tipo 1
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => HomeViewSelector(
              user: authNotifier.user,
            ),
            childCount: 1,
          )),
        ],
      )),
    );
  }
}
