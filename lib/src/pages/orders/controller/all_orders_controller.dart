import 'package:get/get.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../models/order_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../orders_result/orders_result.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];

  final ordersRopository = OrdersRopository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRopository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        //colocando orders..sort os atributos para formatar os pedidos
        allOrders = orders
          ..sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
        update();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
