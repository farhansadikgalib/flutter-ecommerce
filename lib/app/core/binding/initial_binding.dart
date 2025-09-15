import 'package:get/get.dart';
import 'package:ousadbazar/app/modules/categories/controllers/categories_controller.dart';
import 'package:ousadbazar/app/modules/wishlist/controllers/wishlist_controller.dart';
import '../../modules/cart/controllers/cart_controller.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/login/controllers/login_controller.dart';
import '../connection_manager/connection_manager_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    ConnectionManagerBinding().dependencies();
    Get.put(CategoriesController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(WishlistController(), permanent: true);
    Get.put(LoginController(), permanent: true);

  }
}
