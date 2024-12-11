import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../../features/auth/presentation/providers/providers.dart';
import '../../../core.dart';
import '../../../../features/rrhh/presentation/views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData(
        (connectivityResult) async {
          showConnectivitySnackBar(context, connectivityResult);
          if (connectivityResult == ConnectivityResult.none) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
            await ref.read(authNotifierProvider.notifier).checkAuthStatus();
          }
        },
      );
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const CustomSliverAppBar(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => const HomeViewRRHH(),
            childCount: 1,
          )),
        ],
      )),
    );
  }
}
