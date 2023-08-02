
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';

import '../../../constants/endpoints.dart';
import '../../../models/category_model.dart';
import '../../../services/http_manager.dart';

class HomeRespository {
  final HttpManager _httpManager = HttpManager();

  //buscando as categorias no servidor
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      Endpoints.getAllCategories,
      HttpMethods.post,
      {},
      {},
    );

    if (result['result'] != null) {
      //Lista categorias no servidor do class CategoryModel
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      //Error
      return HomeResult.error(
          "Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }

  //buscando os valores produtos servidor
  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      Endpoints.getAllProducts,
      HttpMethods.post,
      {},
      body,
    );

    if (result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          //teve que converte list para listItemModel
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          "Ocorreu um erro inesperado ao recuperar os itens");
    }
  }
}
