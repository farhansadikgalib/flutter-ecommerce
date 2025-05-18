import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/data/remote/repository/category/category_repository.dart';

import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/categorywiseproducts_response.dart';

class ProductCategoryController extends GetxController {
  final priceRange = RangeValues(0, 1000).obs;
  final category = <Category>[].obs;
  final brands = <Brand>[].obs;
  final collections = <Brand>[].obs;
  final deliveryType = <Brand>[].obs;
  final categorySlug = Get.arguments['slug'];
  final categoryName = Get.arguments['name'];
  final brandId = Get.arguments['brandId'];

  final categoryProducts = <CategoryProducts>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategoryWiseProducts(categorySlug, brandId, '', '', '');
  }

  getCategoryWiseProducts(
    String categorySlug,
    String brandId,
    String deliveryId,
    minPrice,
    maxPrice,
  ) async {
    isLoading.value = true;
    var response = await CategoryRepository().getCategoryWiseProduct(
      categorySlug,
      brandId,
      deliveryId,
      minPrice,
      maxPrice,
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
      deliveryType.addAll(response.data?.shipping ?? []);
    } else {
      printLog(response.message);
    }
    isLoading.value =false;
  }

  void filterProducts() async {
    final selectedBrandIds = brands
        .where((brand) => brand.isSelected == true)
        .map((brand) => brand.id.toString())
        .join(', ');
    printLog(selectedBrandIds);

    final selectedCategoryIds = category
        .where((category) => category.isSelected == true)
        .map((category) => category.id.toString())
        .join(', ');
    printLog(selectedCategoryIds);
    final selectedCollectionIds = collections
        .where((collection) => collection.isSelected == true)
        .map((collection) => collection.id.toString())
        .join(', ');
    printLog(selectedCollectionIds);
    final selectedDeliveryTypeIds = deliveryType
        .where((deliveryType) => deliveryType.isSelected == true)
        .map((deliveryType) => deliveryType.id.toString())
        .join(', ');
    printLog(selectedDeliveryTypeIds);
    final selectedPriceRange =
        '${priceRange.value.start} - ${priceRange.value.end}';
    printLog(selectedPriceRange);
    getCategoryWiseProducts(
      selectedCategoryIds,
      selectedBrandIds,
      selectedDeliveryTypeIds,
      priceRange.value.start.toString(),
      priceRange.value.end.toString(),
    );
  }
}
