import 'package:get/get.dart';

import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/ecom_categories_response.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';
import '../../../data/remote/repository/home/home_repository.dart';

class CategoriesController extends GetxController {
  final ecomCategories = <EcomCategoriesResponse>[].obs;
  final selectedCategoryIndex = (-1).obs;

  final categoryWiseProducts = <ProductData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEcomCategories();
  }

  void getEcomCategories() async {
    var response = await HomeRepository().getEcomCategories();
    if (response.isNotEmpty) {
      ecomCategories.clear();
      ecomCategories.addAll(response);
      getCategoryWiseProduct(ecomCategories.first.id.toString());
      printLog('Ecom Categories: ${response.length}');
      // Auto-select first category if available
      if (response.isNotEmpty) {
        selectedCategoryIndex.value = 0;
      }
    }
  }

  Future<void> getCategoryWiseProduct( String categoryId)async {
    categoryWiseProducts.clear();
    var response = await HomeRepository().getCategoryWiseProduct(categoryId);
    categoryWiseProducts.addAll(response.data??[]);
    printLog('Category Wise Products: ${response.data?.length}');
  }




  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    if (index >= 0 && index < ecomCategories.length) {
      getCategoryWiseProduct(ecomCategories[index].id.toString());
    }

    printLog('Selected Category Index: $index');
  }
}
