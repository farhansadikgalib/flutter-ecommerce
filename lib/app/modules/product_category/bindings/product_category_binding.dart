import 'package:get/get.dart';

import '../controllers/product_category_controller.dart';

class ProductCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductCategoryController>(
      () => ProductCategoryController(),
    );
  }
}
