import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class NewGeneralOrderScreen extends ConsumerStatefulWidget {
  static const String routeName = 'new_general_order_screen';
  const NewGeneralOrderScreen({super.key});

  @override
  NewGeneralOrderScreenState createState() => NewGeneralOrderScreenState();
}

class NewGeneralOrderScreenState extends ConsumerState<NewGeneralOrderScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(breakfastSaucersByScheduleProvider(3).notifier).loadNextPage();
    ref.read(lunchSaucersByScheduleProvider(4).notifier).loadNextPage();
    ref.read(dinnerSaucersByScheduleProvider(5).notifier).loadNextPage();
  }

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String get startTimeString =>
      startTime == null ? 'Seleccione la hora' : startTime!.format(context);
  String get endTimeString =>
      endTime == null ? 'Seleccione la hora' : endTime!.format(context);

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final breakfastSaucers = ref.watch(breakfastSaucersByScheduleProvider(3));
    final lunchSaucers = ref.watch(lunchSaucersByScheduleProvider(4));
    final dinnerSaucers = ref.watch(dinnerSaucersByScheduleProvider(5));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orden general'),
      ),
      // Pantalla para selecciona la fecha de inicio y fin de la orden
      body: Column(
        children: [
          // Fecha de inicio
          ListTile(
            title: const Text('Fecha de inicio'),
            subtitle: Text(startTimeString),
            trailing: const Icon(Icons.access_time_rounded),
            onTap: () => pickStartTime(context),
          ),
          // Fecha de fin
          ListTile(
            title: const Text('Fecha de fin'),
            subtitle: Text(endTimeString),
            trailing: const Icon(Icons.more_time_rounded),
            onTap: () => pickEndTime(context),
          ),
          SaucersWithScheduleListView(
            scheduleName: 'Desayuno',
            iconData: Icons.breakfast_dining,
            scheduleId: 3,
            saucers: breakfastSaucers.saucers,
            value: ref
                .read(breakfastSaucersByScheduleProvider(3))
                .selectedSaucerId,
            onChanged: ref
                .read(breakfastSaucersByScheduleProvider(3).notifier)
                .selectSaucer,
          ),
          SaucersWithScheduleListView(
            scheduleName: 'Almuerzo',
            iconData: Icons.lunch_dining,
            scheduleId: 4,
            saucers: lunchSaucers.saucers,
            value: ref.read(lunchSaucersByScheduleProvider(4)).selectedSaucerId,
            onChanged: ref
                .read(lunchSaucersByScheduleProvider(4).notifier)
                .selectSaucer,
          ),
          SaucersWithScheduleListView(
            scheduleName: 'Cena',
            iconData: Icons.dinner_dining,
            scheduleId: 5,
            saucers: dinnerSaucers.saucers,
            value:
                ref.read(dinnerSaucersByScheduleProvider(5)).selectedSaucerId,
            onChanged: ref
                .read(dinnerSaucersByScheduleProvider(5).notifier)
                .selectSaucer,
          ),
          // Botón para guardar la orden
          ElevatedButton(
            onPressed: ref.watch(generalOrderFormProvider).isPosting
                ? null // Desactiva el botón si el formulario está posteando
                : () async {
                    if (startTime == null || endTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Seleccione fechas válidas')),
                      );
                      return;
                    }

                    // Validar si las fechas son iguales
                    if (startTime!.hour == endTime!.hour &&
                        startTime!.minute == endTime!.minute) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Las fechas de inicio y fin no pueden ser iguales')),
                      );
                      return;
                    }

                    // Validar que haya al menos una hora de diferencia
                    final duration = endTime!.hour - startTime!.hour;
                    if (duration < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'La diferencia entre las fechas debe ser de al menos una hora')),
                      );
                      return;
                    }

                    final breakfast = ref
                        .read(breakfastSaucersByScheduleProvider(3))
                        .selectedSaucerId;
                    final lunch = ref
                        .read(lunchSaucersByScheduleProvider(4))
                        .selectedSaucerId;
                    final dinner = ref
                        .read(dinnerSaucersByScheduleProvider(5))
                        .selectedSaucerId;

                    await ref
                        .read(generalOrderFormProvider.notifier)
                        .onSaucerSubmit(
                          context,
                          breakfast,
                          lunch,
                          dinner,
                          startTime!,
                          endTime!,
                        )
                        .then(
                      (value) {
                        if (!value) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Orden guardada')),
                        );
                      },
                    ).onError(
                      (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error al guardar la orden')),
                        );
                      },
                    ).timeout(
                      const Duration(seconds: 10),
                      onTimeout: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Tiempo de espera agotado')),
                        );
                      },
                    );
                  },
            child: ref.watch(generalOrderFormProvider).isPosting
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Text('Guardar orden'),
          ),
        ],
      ),
    );
  }

  Future pickStartTime(BuildContext context) async {
    final initialTime = TimeOfDay(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
    );
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (newTime == null) return;
    setState(() => startTime = newTime);
  }

  Future pickEndTime(BuildContext context) async {
    final initialTime = TimeOfDay(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
    );
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (newTime == null) return;
    setState(() => endTime = newTime);
  }
}

class SaucersWithScheduleListView extends StatelessWidget {
  const SaucersWithScheduleListView({
    super.key,
    required this.scheduleName,
    required this.iconData,
    required this.scheduleId,
    this.onChanged,
    this.loadNextPage,
    required this.saucers,
    required this.value,
  });
  final String scheduleName;
  final IconData iconData;
  final int scheduleId;
  final ValueChanged<int?>? onChanged;
  final VoidCallback? loadNextPage;
  final List<Saucer> saucers;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                scheduleName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(iconData),
            ],
          ),
          const SizedBox(height: 10),
          RadioListsSaucers(
            scheduleId: scheduleId,
            onChanged: onChanged,
            loadNextPage: loadNextPage,
            saucers: saucers,
            value: value,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
