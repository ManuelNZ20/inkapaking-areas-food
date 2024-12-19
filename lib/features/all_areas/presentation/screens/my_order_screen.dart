import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class MyOrderScreen extends ConsumerWidget {
  static const String routeName = 'my_order_screen';
  const MyOrderScreen({
    super.key,
    required this.userId,
  });
  final int userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalOrder = ref.watch(getGeneralOrderWithSaucersProvider);
    final myOrderForm = ref.watch(myOrderFormProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Orden'),
      ),
      body: Column(
        children: [
          generalOrder.when(
            data: (data) {
              final saucers = data!.saucers;
              if (saucers == null) {
                return const Text('No hay ordenes para hoy');
              }
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            title: Text(saucers[0].nameSaucer),
                            subtitle: Text(saucers[0].nameDrink),
                            value: myOrderForm.breakfast,
                            onChanged: ref
                                .read(myOrderFormProvider.notifier)
                                .onBreakfastChange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            secondary: const Icon(Icons.fastfood),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            title: Text(saucers[1].nameSaucer),
                            subtitle: Text(saucers[1].nameDrink),
                            value: myOrderForm.lunch,
                            onChanged: ref
                                .read(myOrderFormProvider.notifier)
                                .onLunchChange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            secondary: const Icon(Icons.fastfood),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            title: Text(saucers[2].nameSaucer),
                            subtitle: Text(saucers[2].nameDrink),
                            value: myOrderForm.dinner,
                            onChanged: ref
                                .read(myOrderFormProvider.notifier)
                                .onDinnerChange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            secondary: const Icon(Icons.fastfood),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
            loading: () {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // Agregar botón para enviar la orden
          FilledButton(
            onPressed: () {
              ref
                  .read(myOrderFormProvider.notifier)
                  .createOrder(userId)
                  .then((value) {
                if (!value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al enviar la orden'),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Orden enviada'),
                  ),
                );
              }).onError(
                (error, stackTrace) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error al enviar la orden'),
                    ),
                  );
                },
              );
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Enviar Orden'),
          ),
        ],
      ),
    );
  }
}
