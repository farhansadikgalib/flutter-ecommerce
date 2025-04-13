import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import 'package:turi/app/data/remote/model/product/product_details_response.dart';
import 'package:turi/app/data/remote/repository/product/product_repository.dart';

class ProductDetailsController extends BaseController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  ProductCollection product = Get.arguments['product'];

  final productDetails = <ProductDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    printLog(product.title);
    printLog(product.id);
    getProductDetails();

  }


  getProductDetails()async{

    var response = await ProductRepository().getProductDetails(product.id.toString());
    if(response.status==200){
      productDetails.clear();
      productDetails.add(response.data!);
    }else{
      printLog(response.message);
      AppWidgets().getSnackBar(message: response.message.toString());
    }
  }



}
