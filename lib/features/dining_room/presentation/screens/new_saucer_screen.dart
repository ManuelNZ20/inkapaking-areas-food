import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/widgets/widgets.dart';
import '../../../home/presentation/providers/providers.dart';
import '../../domain/domain.dart';
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
    // TODO:formstate
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Platillo'),
        ),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: SaucerForm(
              saucer: null,
            ),
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
    // TODO: form state and save button
    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: CustomTextField(
            label: 'Platillo',
            hint: 'Ingrese el nombre del platillo',
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: CustomTextField(
            label: 'Bebida',
            hint: 'Ingrese el nombre de la bebida',
          ),
        ),
        const SizedBox(height: 20),
        SegmentedButtonSchedule(
          selected: const <int>{3},
          onSelectionChanged: (p0) {},
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: FilledButton(
            onPressed: () async {},
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
