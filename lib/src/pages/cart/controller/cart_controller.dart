import 'package:get/get.dart';
import 'package:greengrocer/src/models/item_model.dart';

import '../../../models/cart_item_model.dart';
import '../../../services/utils_services.dart';
import '../../auth/controller/auth_controller.dart';
import '../cart_result/cart_result.dart';
import '../repository/cart_repository.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  //metodo que vai fazer calculo total carrinho
  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<bool> changeItemQuantity(CartItemModel item, int quantity) async {
    cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    return false;
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
    return cartItems.indexWhere((itemInList) => itemInList.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    //verificando se tem ou nao item no carrinho comprar
    if (itemIndex >= 0) {
      //ja existe
      cartItems[itemIndex].quantity += quantity;
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
          //nao existe
          CartItemModel(
            id: cartItemId,
            item: item,
            quantity: quantity,
          );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );

      //nao existe
      /*
      CartItemModel(
        id: '',
        item: item,
        quantity: quantity,
      );
      */
    }

    //atualizando carrinho
    update();
  }
}
