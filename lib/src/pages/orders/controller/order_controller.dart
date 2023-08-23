import 'package:get/get.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';

import '../../auth/controller/auth_controller.dart';

class OrderController {
  final ordersRopository = OrdersRopository();
  final authController = Get.find<AuthController>();

  Future<void> getOrderItems() async {
    ordersRopository.getOrderItems(
      orderId: '',
      token: '',
    );
  }
}
