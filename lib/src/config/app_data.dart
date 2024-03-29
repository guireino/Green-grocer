import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

import '../models/order_model.dart';

// este arquivo pode ser deletado porque todas informasao vem backend

// instanciando informacao dos produtos
// ItemModel apple = ItemModel(
//   imgUrl: 'assets/fruits/apple.png',
//   itemName: 'Maçã',
//   unit: 'kg',
//   description:
//       'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
//   price: 5.5,
// );

// ItemModel grape = ItemModel(
//   imgUrl: 'assets/fruits/grape.png',
//   itemName: 'Uva',
//   price: 7.4,
//   unit: 'kg',
//   description:
//       'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
// );

// ItemModel guava = ItemModel(
//   imgUrl: 'assets/fruits/guava.png',
//   itemName: 'Goiaba',
//   price: 11.5,
//   unit: 'kg',
//   description:
//       'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
// );

// ItemModel kiwi = ItemModel(
//   imgUrl: 'assets/fruits/kiwi.png',
//   itemName: 'Kiwi',
//   price: 2.5,
//   unit: 'un',
//   description:
//       'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
// );

// ItemModel mango = ItemModel(
//   imgUrl: 'assets/fruits/mango.png',
//   itemName: 'Manga',
//   price: 2.5,
//   unit: 'un',
//   description:
//       'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
// );

// ItemModel papaya = ItemModel(
//   imgUrl: 'assets/fruits/papaya.png',
//   itemName: 'Mamão papaya',
//   price: 8,
//   unit: 'kg',
//   description:
//       'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
// );

// Lista de produtos
// List<ItemModel> items = [
//   apple,
//   grape,
//   guava,
//   kiwi,
//   mango,
//   papaya,
// ];

List<String> categories = [
  'Frutas',
  'Grão',
  'Verduras',
  'Temperos',
  'Careais',
];

List<CartItemModel> cartItems = [
  //CartItemModel(item: apple, quantity: 1),
  //CartItemModel(item: mango, quantity: 1),
  //CartItemModel(item: guava, quantity: 3),
];

UserModel user = UserModel(
  name: "Joao Pedro",
  email: "joao@email.com",
  phone: "99 9 8888-8888",
  cpf: "999.999.999-88",
  password: "",
);

List<OrderModel> orders = [
  /*

  //Pedido 1
  OrderModel(
    id: "fsdaferf456",
    status: "pending_payment",
    copyAndPaste: "remjweljslfjsdl",
    total: 11.0,
    createdDateTime: DateTime.parse(
      "2023-06-16 18:00:10.450",
    ),
    overdueDateTime: DateTime.parse(
      "2023-06-16 18:00:10.450",
    ),
    items: [
      // CartItemModel(
      //   item: apple,
      //   quantity: 2,
      // ),
      // CartItemModel(
      //   item: mango,
      //   quantity: 2,
      // ),
    ], qrCodeImage: '',
  ),

  //Pedido 2
  OrderModel(
    id: "46546asd564fsd4",
    status: "delivered",
    copyAndPaste: "a6545dfasfasfaf",
    total: 11.5,
    createdDateTime: DateTime.parse(
      "2023-06-16 11:00:10.650",
    ),
    overdueDateTime: DateTime.parse(
      "2023-06-20 17:00:10.650",
    ),
    items: [
      // CartItemModel(
      //   item: guava,
      //   quantity: 1,
      // ),
    ], qrCodeImage: '',
  ),

  */
];
