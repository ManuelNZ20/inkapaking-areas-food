import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HistorialGeneralOrderScreen extends ConsumerWidget {
  static const String routeName = 'historial_general_order_screen';
  const HistorialGeneralOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialGeneralOrder = ref.watch(generalNotifierProvider);
    // Usamos ref.listen para que se actualice solo cuando entras a la pantalla
    ref.listen<List<GeneralOrder>>(generalNotifierProvider, (_, __) {
      if (historialGeneralOrder.isEmpty) {
        ref.read(generalNotifierProvider.notifier).listGeneralOrders();
      }
    });
    // Función que se llama cuando el usuario hace pull-to-refresh
    Future<void> onRefresh() async {
      await ref.read(generalNotifierProvider.notifier).listGeneralOrders();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial O.G.'),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: historialGeneralOrder.isEmpty
            ? const Center(
                child: Text('No hay ordenes generales'),
              )
            : ListView.builder(
                itemCount: historialGeneralOrder.length,
                itemBuilder: (context, index) {
                  final order = historialGeneralOrder[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .1,
                            child: ListTile(
                              title: Text('#${order.generalOrderId}'),
                              subtitle: Text(order.createdAt),
                            ),
                          ),
                          ContainerListSaucers(
                            saucers: order.saucers!,
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
