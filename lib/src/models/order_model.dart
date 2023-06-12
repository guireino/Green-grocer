import 'cart_item_model.dart';

class OrderModel {
  String id, status, copyAndPaste;
  double total;
  DateTime createdDateTime, overdueDateTime;
  List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
  });
}
