import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/cart/cart_items_response.dart';
import 'package:turi/app/data/remote/repository/cart/cart_repository.dart';

import '../../../data/remote/model/home/home_response.dart';
import '../../home/controllers/home_controller.dart';

class CartController extends BaseController {
  final totalPrice = 0.0.obs;
  final cartCount = 0.obs;
  final cartProducts = <ProductCollection>[].obs;
  final allCartProducts = <CartProducts>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
/*    Get.find<HomeController>().reactive;
    final homeController = Get.find<HomeController>();
    ever(homeController.homeElements, (value) {
      homeController.refresh();
      cartCalculation();
    });*/
  }

  @override
  void onReady() {
    super.onReady();
    cartProducts.refresh();
  }

  void cartCalculation() {
    totalPrice.value = 0.0;
    for (var element in allCartProducts) {
      totalPrice.value +=
          double.parse(element.flashProduct!.selling!) * element.quantity!;
    }
  }

  void getCartItems() async {
    isLoading.value = true;
    var response = await CartRepository().getCartItems();

    cartCount.value = 0;
    allCartProducts.clear();
    if (response.status == 200) {
      allCartProducts.addAll(response.data!);
      cartCount.value = response.data!.length;
      cartCalculation();
    } else {
      printLog("Error fetching cart items: ${response.message}");
    }
    isLoading.value = false;
  }

  void addToCart(
    String productId,
    String productQty,
    String inventoryId,
  ) async {
    var response = await CartRepository().addToCart(
      productId,
      inventoryId,
      productQty,
    );

    if (response.status == 200) {
      getCartItems();
    } else {
      printLog("Error adding to cart: ${response.message}");
    }
  }

  void deleteCartItems(String productId) async {
    var response = await CartRepository().deleteCartItems(productId);

    if (response.status == 200) {
      getCartItems();
    } else {
      printLog("Error deleting cart item: ${response.message}");
    }
  }
}
