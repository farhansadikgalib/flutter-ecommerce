import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:turi/app/data/remote/repository/product/product_repository.dart';

import '../../../data/remote/model/product/product_review_response.dart';

class ProductDetailsController extends BaseController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  ProductData product = Get.arguments['product'];

/*  final productDetails = <ProductDetails>[].obs;
  final imageList = <ProductImage>[].obs; */

  final productDetails = [].obs;
  final imageList = [].obs;
  final productReview = <ProductReview>[].obs;
  final wishlistItem = false.obs;

  @override
  void onInit() {
    super.onInit();

   getProductDetails();
    // getProductReview();
  }

  getProductDetails() async {
    var response = await ProductRepository().getProductDetails(
      product.id.toString(),
    );

      productDetails.clear();
      imageList.clear();
      productDetails.add(response.product);

      // wishlistItem.value = productDetails.first.wishlisted ==null?  false:true;


  }

  void getProductReview()async {
    var response = await ProductRepository().getProductReview(
      product.id.toString(),
    );

    if(response.status == 200) {
   //   productReview.addAll(response.data! as Iterable<ProductReview>);
    } else {
      printLog(response.message);
      AppWidgets().getSnackBar(message: response.message.toString());
    }

  }
}
