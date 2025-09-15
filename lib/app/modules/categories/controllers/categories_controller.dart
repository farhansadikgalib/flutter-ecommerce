import 'package:get/get.dart';

import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/ecom_categories_response.dart';
import '../../../data/remote/repository/home/home_repository.dart';

class CategoriesController extends GetxController {
  final ecomCategories = <EcomCategoriesResponse>[].obs;
  final selectedCategoryIndex = (-1).obs;

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
      printLog('Ecom Categories: ${response.length}');
      // Auto-select first category if available
      if (response.isNotEmpty) {
        selectedCategoryIndex.value = 0;
      }
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
