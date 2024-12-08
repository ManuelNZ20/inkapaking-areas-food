import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class OrdersAllAreasScreen extends ConsumerStatefulWidget {
  static const String routeName = 'orders_all_areas_screen';
  const OrdersAllAreasScreen({super.key});

  @override
  OrdersAllAreasScreenState createState() => OrdersAllAreasScreenState();
}

class OrdersAllAreasScreenState extends ConsumerState<OrdersAllAreasScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(typeUsersNotifierProvider.notifier).loadTypeUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final typeUsersState = ref.watch(typeUsersNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordenes de todas las áreas'),
      ),
      body: typeUsersState.isLoading == true
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                Text('Cargando áreas de trabajo...'),
              ],
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: typeUsersState.typeUsers!.length,
              itemBuilder: (context, index) {
                final typeUser = typeUsersState.typeUsers![index];
                if (typeUser.typeUserId == 1) return const SizedBox();
                return CardAreaWork(
                  idArea: '${typeUser.typeUserId}',
                  nameArea: typeUser.typeName,
                  statusArea: 'Activo',
                  numberArea: 3,
                  notificationsArea: 3,
                );
              },
            ),
    );
  }
}
