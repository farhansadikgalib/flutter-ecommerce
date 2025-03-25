import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/modules/home/controllers/home_controller.dart';

class CartController extends BaseController {

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
    cartFilter();
  }

  cartFilter() {

    Get.find<HomeController>().homeElements.first.collections!.forEach(
      (element) {
        element.productCollections!.forEach((product) {

          if (product.addToCart == true) {
            printLog(product.title);
          }

        });
      }
    );
  }



}
