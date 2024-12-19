import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class HistorialMyOrdersScreen extends ConsumerStatefulWidget {
  static const String routeName = 'historial_my_order_screen';
  const HistorialMyOrdersScreen({
    super.key,
    required this.userId,
  });

  final int userId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistorialMyOrdersScreenState();
}

class _HistorialMyOrdersScreenState
    extends ConsumerState<HistorialMyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(listMyOrdersProvider(widget.userId).notifier).listMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final historialMyOrders = ref.watch(listMyOrdersProvider(widget.userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de mis ordenes'),
      ),
      body: historialMyOrders.isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : historialMyOrders.hasError == true
              ? Center(
                  child: Text(historialMyOrders.errorMessage),
                )
              : historialMyOrders.orders.isEmpty
                  ? const Center(
                      child: Text('No hay ordenes'),
                    )
                  : ListView.builder(
                      itemCount: historialMyOrders.orders.length,
                      itemBuilder: (context, index) {
                        final order = historialMyOrders.orders[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .09,
                                  child: ListTile(
                                    title: Text('#${order.orderId}'),
                                    subtitle: Text(order.createdAt),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      if (order.breakfast)
                                        const ContainerCardSaucer(
                                          nameSaucer: 'Desayuno',
                                          iconData:
                                              Icons.breakfast_dining_outlined,
                                        ),
                                      if (order.lunch)
                                        const ContainerCardSaucer(
                                          nameSaucer: 'Almuerzo',
                                          iconData: Icons.lunch_dining_outlined,
                                        ),
                                      if (order.dinner)
                                        const ContainerCardSaucer(
                                          nameSaucer: 'Cena',
                                          iconData:
                                              Icons.dinner_dining_outlined,
                                        ),
                                    ],
                                  ),
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

class ContainerCardSaucer extends StatelessWidget {
  const ContainerCardSaucer({
    super.key,
    required this.nameSaucer,
    required this.iconData,
  });
  final String nameSaucer;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              Text(nameSaucer),
            ],
          ),
        ),
      ),
    );
  }
}
