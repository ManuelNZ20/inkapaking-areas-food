import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class SegmentedButtonSchedule extends ConsumerWidget {
  const SegmentedButtonSchedule({
    super.key,
    required this.selected,
    required this.onSelectionChanged,
  });
  final Set<int> selected;
  final Function(Set<int>) onSelectionChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listSchedule = ref.watch(schedulesProvider);
    return listSchedule.when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Horario de comida'),
            const SizedBox(height: 20),
            SegmentedButton<int>(
              segments: data
                  .map(
                    (e) => ButtonSegment<int>(
                      value: e.schedules.scheduleId,
                      icon: Icon(e.icon),
                      label: Text(e.schedules.name),
                    ),
                  )
                  .toList(),
              selected: selected,
              onSelectionChanged: onSelectionChanged,
            ),
          ],
        );
      },
      error: (e, s) => const Text('Error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
