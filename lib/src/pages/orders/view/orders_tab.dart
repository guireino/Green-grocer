import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/all_orders_controller.dart';
import 'components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemBuilder: (_, index) => OrderTile(
                  order: controller.allOrders[index]), // appData.orders[index]
              // Text(appData.orders[index].id);
              itemCount: controller.allOrders.length, // appData.orders.length
            ),
          );
        },
      ),
    );
  }
}
