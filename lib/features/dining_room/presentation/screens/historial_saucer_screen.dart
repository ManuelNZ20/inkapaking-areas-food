import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/core.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HistorialSaucerScreen extends ConsumerWidget {
  static const String routeName = 'historial_saucer_screen';
  const HistorialSaucerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listSchedule = ref.watch(schedulesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de platillos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: listSchedule.when(
                data: (data) {
                  return data
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DividerTitleTypeSchedule(
                              titleSchedule: e.schedules.name,
                              iconData: e.icon,
                            ),
                            const SizedBox(height: 10),
                            ContainerListSaucerWithSchedule(
                              scheduleId: e.schedules.scheduleId,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                      .toList();
                },
                error: (e, s) => [
                  Text('Error ${e.toString()}'),
                ],
                loading: () => [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .8,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Cargando datos...'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
