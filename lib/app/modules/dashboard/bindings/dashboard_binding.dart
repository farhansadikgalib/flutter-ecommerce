import 'package:get/get.dart';
import 'package:ousadbazar/app/modules/cart/controllers/cart_controller.dart';
import 'package:ousadbazar/app/modules/home/controllers/home_controller.dart';
import 'package:ousadbazar/app/modules/login/controllers/login_controller.dart';
import 'package:ousadbazar/app/modules/order/controllers/order_controller.dart';
import 'package:ousadbazar/app/modules/profile/controllers/profile_controller.dart';
import 'package:ousadbazar/app/modules/wishlist/controllers/wishlist_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CartController>(() => CartController());

    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<WishlistController>(() => WishlistController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
