import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';

import '../../../models/cart_item_model.dart';
import '../../../services/utils_services.dart';
import '../../auth/controller/auth_controller.dart';
import '../../common_widgets/payment_dialog.dart';
import '../cart_result/cart_result.dart';
import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  /* //quantidade de itens do carrinho de forma unitária
  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }
  */

  //metodo que vai fazer calculo total carrinho
  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);

    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setCheckoutLoading(false);

    result.when(
      success: (order) {
        cartItems.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(
              //esse objeto que vai pegar keycode e mostra para usuario
              order: order,
            );
          },
        );
      },
      error: (message) {
        utilsServices.showToast(
          message: "Pedido não confirmado",
          //isError: true,
        );
      },
    );
  }

  //metodo que vai fazer mudanca quantidade produto
  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      //verificando quantidade item
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        //add item na na primeira vez
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      utilsServices.showToast(
        message: "Ocorreu um erro ao alterar a quantidade do produto",
        isError: true,
      );
    }

    return result;
  }

  //passando os dados para cart
  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();

        //print(data);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    print('getItemIndex(item) $getItemIndex(item)');
    print('item $item');

    //verificando se tem ou nao item no carrinho comprar
    if (itemIndex >= 0) {
      //ja existe
      final product = cartItems[itemIndex];
      //cartItems[itemIndex].quantity += quantity;

      await changeItemQuantity(
          item: product, quantity: (product.quantity + quantity));

      /*
      if (result) {
        cartItems[itemIndex].quantity += quantity;
      } else {
        utilsServices.showToast(
          message: "Ocorreu um erro ao alterar a quantidade do produto",
          isError: true,
        );
      }
      */
    } else {
      //add info do repositorio
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }

    //atualizando carrinho
    update();
    print('update');
  }
}
