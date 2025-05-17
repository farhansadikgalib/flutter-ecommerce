import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
    );
    Get.lazyPut<CartController>(
          () => CartController(),
    );
  }
}
