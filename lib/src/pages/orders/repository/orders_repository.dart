import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

import '../../../constants/endpoints.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';

class OrdersRopository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.getOrderItems,
      HttpMethods.post,
      {'X-Parse-Session-Token': token},
      {'orderId': orderId},
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error(
        "Não foi possivel recuperar os produtos do pedido",
      );
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.getAllOrders,
      HttpMethods.post,
      {'X-Parse-Session-Token': token},
      {'user': userId},
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error("Não foi possivel recuperar os pedidos");
    }
  }
}
