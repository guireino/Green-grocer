import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/cart/view/components/cart_tile.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../config/custom_colors.dart';
import '../controller/cart_controller.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  // class que ira formatar preco
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  /*
  void removeItemFromCart(CartItemModel cartItem) {
     setState(() {
       appData.cartItems.remove(cartItem);
       utilsServices.showToast(
         message: '${cartItem.item.itemName} removido(a) do carrinho!!');
    });
  }
  */

  double cartTotalPrice() {
    // double total = 0;

    // for (var item in appData.cartItems) {
    //   total += item.totalPrice();
    // }

    // return total;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        // lista de itens do carrinho
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                //verificando se nao tem produto no carrinho
                if (controller.cartItems.isEmpty) {
                  //mensagem avisando que nao tem produto no carrinho com icon
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                      ),
                      const Text("Não há itens no carrinho"),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount:
                      controller.cartItems.length, //appData.cartItems.length,
                  itemBuilder: (_, index) {
                    //final cartItem = appData.cartItems[index];
                    //return Text(appData.cartItems[index].item.itemName);
                    return CartTile(
                      cartItem: controller
                          .cartItems[index], //appData.cartItems[index],
                      //remove: removeItemFromCart,

                      /*
                            updatedQuantity: (qtd) {
                              if (qtd == 0) {
                                removeItemFromCart(appData.cartItems[index]);
                              } else {
                                setState(() => cartItem.quantity = qtd);
                              }
                            },
                      */
                    );
                  },
                );
              },
            ),
          ),
          //const SizedBox(height: 20),

          // a part prico produto e botao confimar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      // formatar preco
                      utilsServices
                          .priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.customSwatchColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: (controller.isCheckoutLoading ||
                                controller.cartItems.isEmpty)
                            ? null
                            : () async {
                                // confimando comprar do carrinho
                                bool? result = await showOrderConfirmation();
                                //print(result);
                                // se dialog confirmação escolher sim

                                //se usuario nao confimar conprar
                                if (result ?? false) {
                                  cartController.checkoutCart();
                                } else {
                                  utilsServices.showToast(
                                      message: "Pedido não confirmar");
                                }

                                //else {
                                // utilsServices.showToast(
                                //   message: "Pedido não confirmado",
                                //   //isError: true,
                                // );
                                //}
                              },
                        child: controller.isCheckoutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Concluir pedido',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
