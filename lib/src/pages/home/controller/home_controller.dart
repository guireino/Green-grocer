import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';

import '../../../services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRespository = HomeRespository();
  final utilsServices = UtilsServices();

  bool isCategoryLoading = false, isProductLoading = true;

  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  //variavel observado
  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) {
      return true;
    }

    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    // if isProduct for negacao
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();

    //fazendo esperar um tempo para que usuario escreva
    debounce(
      searchTitle,
      (_) {
        update();
        //print(searchTitle);
      },
      time: const Duration(milliseconds: 600),
    );

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;

    update();

    if (currentCategory!.items.isNotEmpty) {
      return;
    }

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRespository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        // se todas categorias estiver fazias
        if (allCategories.isEmpty) {
          return;
        }

        //print('Todas as categorias: $allCategories');
        selectCategory(allCategories.first);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void filterByTitle() {
    //Apager todos os produtos das categorias
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        //Criar uma nova categoria com todos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = allCategories.first;

    update();
    getAllProducts();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;

    getAllProducts(canLoad: false);
  }

  //buscando todos valor no servidor
  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      // utilisando
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      "itemsPerPage": itemsPerPage,
    };

    HomeResult<ItemModel> result = await homeRespository.getAllProducts(body);

    setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        //print(data);
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
