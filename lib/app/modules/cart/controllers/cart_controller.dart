import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';

import '../../../data/remote/model/home/home_response.dart';
import '../../home/controllers/home_controller.dart';


class CartController extends BaseController {
  final totalPrice = 0.0.obs;
  final cartProducts = <ProductCollection>[].obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<HomeController>().reactive;
    final homeController = Get.find<HomeController>();
    ever(homeController.homeElements, (value) {
      homeController.refresh();
      cartCalculation();
    });
  }


  @override
  void onReady() {
    super.onReady();
    cartProducts.refresh();
  }


  cartCalculation() {
    totalPrice.value = 0.0;
    cartProducts.forEach(
      (element) {
        totalPrice.value += double.parse(element.selling!) * element.quantity!;
      },
    );
  }




}
