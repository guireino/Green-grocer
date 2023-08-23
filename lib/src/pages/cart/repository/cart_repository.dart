import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';

import '../../../constants/endpoints.dart';
import '../../../models/cart_item_model.dart';
import '../../../services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.getCartItems,
      HttpMethods.post,
      {
        'X-Parse-Session-Token': token,
      },
      {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      //Tratar
      //print(result['result']);
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      //Retornar uma mensagem
      //print('Ocorreu um erro ao recuperar os itens do carrinho');
      return CartResult.error(
          "Ocorreu um erro ao recuperar os itens do carrinho");
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.checkout,
      HttpMethods.post,
      {
        'X-Parse-Session-Token': token,
      },
      {
        'total': total,
      },
    );

    //checando se finalizacao carrinho
    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);

      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error("Que não possivel realizer o pedido");
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.changeItemQuantity,
      HttpMethods.post,
      ({
        'X-Parse-Session-Token': token,
      }),
      ({
        'cartItemId': cartItemId,
        'quantity': quantity,
      }),
    );

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      Endpoints.addItemToCart,
      HttpMethods.post,
      ({'X-Parse-Session-Token': token}),
      ({
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      }),
    );

    if (result['result'] != null) {
      //add produto
      return CartResult<String>.success(result['result']['id']);
    } else {
      //Erro
      return CartResult.error('Não foi possivel adicionar o item no carrinho');
    }
  }
}
