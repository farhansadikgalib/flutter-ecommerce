import 'package:get/get.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductSearchController>(
      () => ProductSearchController(),
    );
  }
}
