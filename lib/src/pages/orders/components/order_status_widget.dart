import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  // numero dos status da lista pagamentos
  final Map<String, int> allStatus = <String, int>{
    "pending_payment": 0,
    "refunded": 1,
    "paid": 2,
    "preparing_purchase": 3,
    "shipping": 4,
    "delivered": 5,
  };

  int get currentStatus => allStatus[status]!; // ! sempre nao vai ser null

  OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isOverdue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(title: "Pedido confimado", isActive: true),
        const _CustomDivider(),
        // se valor igual 1 "..." add essa list
        if (currentStatus == 1) ...[
          const _StatusDot(
            title: "Pix estornado",
            isActive: true,
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverdue) ...[
          const _StatusDot(
            title: "Pagamento Pix vencido",
            isActive: true,
            backgroundColor: Colors.red,
          ),

          //status pagamentos
        ] else ...[
          _StatusDot(
            title: "pagamento",
            isActive: currentStatus >= 2,
          ),
          const _CustomDivider(),
          _StatusDot(
            title: "Preparando",
            isActive: currentStatus >= 3,
          ),
          const _CustomDivider(),
          _StatusDot(
            title: "Envio",
            isActive: currentStatus >= 4,
          ),
          const _CustomDivider(),
          _StatusDot(
            title: "Entregue",
            isActive: currentStatus == 5,
          ),
        ]
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final String title;
  final bool isActive;
  final Color? backgroundColor;

  const _StatusDot(
      {Key? key,
      required this.title,
      required this.isActive,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwatchColor,
            ),
            color:
                //se valor foi ativo a color backgroundColor se nao CustomColors.customSwatchColor se foi diverente Colors.transparent
                isActive
                    ? backgroundColor ?? CustomColors.customSwatchColor
                    : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(width: 5),
        // Texto
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
