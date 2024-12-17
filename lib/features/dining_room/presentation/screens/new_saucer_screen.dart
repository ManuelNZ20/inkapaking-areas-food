import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/widgets/widgets.dart';
import '../../../home/presentation/providers/providers.dart';
import '../../../home/presentation/screens/screens.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class SaucerFormScreen extends ConsumerWidget {
  static const String routeName = 'saucer_form_screen';
  const SaucerFormScreen({
    super.key,
    required this.saucerId,
  });
  final int saucerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dentro de _setupListeners
    ref.listen(connectivityProvider, (previous, next) async {
      next.whenData((connectivityResult) async {
        await handleConnectivity(context, ref, connectivityResult);
      });
    });
    final saucerState = ref.watch(saucerProvider(saucerId));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Platillo'),
        ),
        body: saucerState.isLoading == true
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  Text('Cargando datos...'),
                ],
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: SaucerForm(saucer: saucerState.saucer!),
                ),
              ),
      ),
    );
  }
}

class SaucerForm extends ConsumerWidget {
  const SaucerForm({
    super.key,
    required this.saucer,
  });
  final Saucer? saucer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      saucerFormProvider(saucer!),
      (previous, next) {
        if (previous?.isPosting == false && next.isPosting == true) {
          // Mostrar SnackBar cuando empieza el guardado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Guardando platillo...')),
          );
        }

        if (previous?.isPosting == true && next.isPosting == false) {
          // Acciones después de terminar de guardar
          if (next.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(next.errorMessage ?? 'Error desconocido')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Platillo guardado')),
            );
            context.pushNamed(HomeScreen.routeName);
          }
        }
      },
    );

    final saucerForm = ref.watch(saucerFormProvider(saucer!));
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: CustomTextField(
            label: 'Platillo',
            hint: 'Ingrese el nombre del platillo',
            initialValue: saucerForm.nameSaucer,
            onChanged: ref
                .read(saucerFormProvider(saucer!).notifier)
                .onNameSaucerChanged,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: CustomTextField(
            label: 'Bebida',
            hint: 'Ingrese el nombre de la bebida',
            initialValue: saucerForm.nameDrink,
            onChanged: ref
                .read(saucerFormProvider(saucer!).notifier)
                .onNameDrinkChanged,
          ),
        ),
        const SizedBox(height: 20),
        SegmentedButtonSchedule(
          selected: <int>{saucerForm.scheduleId},
          onSelectionChanged: ref
              .read(saucerFormProvider(saucer!).notifier)
              .onScheduleIdChanged,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: FilledButton(
            onPressed: () async {
              await ref
                  .read(saucerFormProvider(saucer!).notifier)
                  .onFormSubmit()
                  .then((value) {
                if (!value) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Platillo guardado'),
                  ),
                );
                context.pushNamed(HomeScreen.routeName);
              });
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Guardar'),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
