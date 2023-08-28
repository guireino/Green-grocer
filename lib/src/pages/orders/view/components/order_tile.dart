import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';

import 'package:greengrocer/src/services/utils_services.dart';

import '../../../common_widgets/payment_dialog.dart';
import '../../controller/order_controller.dart';
import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                //verificando se pedito esta pendente e teve cart vai expandido
                //initiallyExpanded: order.status == 'pending_payment', // se pagamento estiver em andamento o expansion vai esta aberto
                onExpansionChanged: (value) {
                  //verifica se esta fazer para nao fica buscando
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      utilsServices.formatDateTime(
                          order.createdDateTime!), // order.createdDateTime
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        //tamanho linha cart
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              // Lista de produtos
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children:
                                        controller.order.items.map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                      // Container(
                                      //   height: 20,
                                      //   color: Colors.red,
                                      //   margin: const EdgeInsets.only(bottom: 10),
                                      // );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              // Divisao de produtos
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),

                              // Status de produtos
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  status: order.status,
                                  isOverdue: order.overdueDateTime.isBefore(
                                    DateTime.now(),
                                  ),
                                ),
                                // Container(
                                //   color: Colors.blue,
                                // ),
                              ),
                            ],
                          ),
                        ),

                        //Total
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Total ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    utilsServices.priceToCurrency(order.total),
                              ),
                            ],
                          ),
                        ),

                        //Botao pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return PaymentDialog(
                                    order: order,
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            icon: Image.asset(
                              'assets/app_images/pix.png',
                              height: 18,
                            ),
                            label: const Text("Ver QR Code Pix"),
                          ),
                        )
                      ],
              );
            },
          )),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(
            utilsServices.priceToCurrency(
              orderItem.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
