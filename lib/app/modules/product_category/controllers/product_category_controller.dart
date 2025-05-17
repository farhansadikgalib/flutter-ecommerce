import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/data/remote/repository/category/category_repository.dart';

import '../../../data/remote/model/category/categorywiseproducts_response.dart';

class ProductCategoryController extends GetxController {

  RangeValues priceRange = const RangeValues(0, 1000);

  final category = <Category>[].obs;
  final  brands = <Brand>[].obs;
  final  collections =<Brand> [].obs;
  final deliveryType = <Brand>[].obs;
  final categorySlug = Get.arguments['slug'];
  final categoryName = Get.arguments['name'];
  final brandId = Get.arguments['brandId'];

  final categoryProducts = <CategoryProducts>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategoryWiseProducts();
  }

  getCategoryWiseProducts() async {
    var response = await CategoryRepository().getCategoryWiseProduct(
      categorySlug,
      brandId,
    );
    if (response.status == 200) {
      categoryProducts.clear();
      category.clear();
      brands.clear();
      collections.clear();
      deliveryType.clear();
      categoryProducts.addAll(response.data?.result?.data ?? []);
      collections.addAll(response.data?.collections ?? []);
      category.addAll(response.data?.category ?? []);
      brands.addAll(response.data?.brands ?? []);
      deliveryType.addAll(response.data?.shipping??[]);
    }
  }
}
