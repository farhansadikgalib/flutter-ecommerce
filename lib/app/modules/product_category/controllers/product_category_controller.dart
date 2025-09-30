import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/data/remote/model/search/search_response.dart';
import 'package:ousadbazar/app/data/remote/repository/category/category_repository.dart';
import '../../../core/helper/debounce_helper.dart';
import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/categorywiseproducts_response.dart';

class ProductCategoryController extends GetxController {
  final DebounceHelper debounceHelper = DebounceHelper();
  final priceRange = RangeValues(0, 1000).obs;
  final category = <CategoryWiseProduct>[].obs;
  final brands = [].obs;
  final collections = [].obs;
  final deliveryType = [].obs;
  final type = Get.arguments['type'];
  final itemName = Get.arguments['name'];
  final id = Get.arguments['id'];
  final fromSearch = Get.arguments['type'] == 'Search' ? true : false;
  final categoryProducts = <CategoryWiseProduct>[].obs;

  final isLoading = false.obs;




  @override
  void onInit() {
    super.onInit();

    if (type == 'Categories') {
      getCategoryWiseProducts(id);
    } else if (type == 'Suppliers') {
      getSupplierWiseProducts(id);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCategoryWiseProducts(int id) async {
    isLoading.value = true;
    var response = await CategoryRepository().getCategoryWiseProduct(id);

    categoryProducts.clear();
    categoryProducts.addAll(response.data ?? []);
    isLoading.value = false;
  }

  Future<void> getSupplierWiseProducts(int id) async {
    isLoading.value = true;
    var response = await CategoryRepository().getSupplierWiseProduct(id);

    categoryProducts.clear();
    categoryProducts.addAll(response.data ?? []);
    isLoading.value = false;
  }

  void filterProducts() async {
    final selectedBrandIds = brands
        .where((brand) => brand.isSelected == true)
        .map((brand) => brand.id.toString())
        .join(', ');
    printLog(selectedBrandIds);

    /*    final selectedCategoryIds = category
        .where((category) => category.isSelected == true)
        .map((category) => category.id.toString())
        .join(', ');*/
    //printLog(selectedCategoryIds);
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
    getCategoryWiseProducts(1);
  }

}
