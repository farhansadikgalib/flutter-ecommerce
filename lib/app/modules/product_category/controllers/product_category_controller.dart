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

  // Pagination variables
  final categoryProductsTotalPage = 0.obs;
  final categoryProductsCurrentPage = 1.obs;
  final isPaginationLoading = false.obs;
  final ScrollController categoryProductsScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    categoryProductsScrollController.addListener(_onScroll);

    if (type == 'Categories') {
      // getCategoryWiseProducts(id, 1);
    } else if (type == 'Suppliers') {
      getSupplierWiseProducts(id, 1);
    }
  }

  void _onScroll() {
    if (categoryProductsScrollController.position.pixels >=
        categoryProductsScrollController.position.maxScrollExtent - 200) {
      if (!isPaginationLoading.value &&
          categoryProductsCurrentPage.value < categoryProductsTotalPage.value) {
        categoryProductsCurrentPage.value++;
/*        if (type == 'Categories') {
          getCategoryWiseProducts(
            id,
            categoryProductsCurrentPage.value,
            isLoadMore: true,
          );
        } else */

          if (type == 'Suppliers') {
          getSupplierWiseProducts(
            id,
            categoryProductsCurrentPage.value,
            isLoadMore: true,
          );
        }
      }
    }
  }

  @override
  void onClose() {
    categoryProductsScrollController.removeListener(_onScroll);
    categoryProductsScrollController.dispose();
    super.onClose();
  }

 /* Future<void> getCategoryWiseProducts(
    int id,
    int page, {
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      isLoading.value = true;
      categoryProductsCurrentPage.value = page;
    } else {
      isPaginationLoading.value = true;
    }

    try {
      var response = await CategoryRepository().getCategoryWiseProduct(
        id,
        page,
      );

      if (response.data!.isNotEmpty) {
        categoryProductsTotalPage.value = response.total!;

        if (isLoadMore) {
          // Append new products to existing list
          categoryProducts.addAll(response.data ?? []);
        } else {
          // Replace existing products
          categoryProducts.clear();
          categoryProducts.addAll(response.data ?? []);
        }

        printLog('Category Products: ${categoryProducts.length}');
        printLog('Current Page: ${categoryProductsCurrentPage.value}');
        printLog('Total Pages: ${categoryProductsTotalPage.value}');
      } else {
        if (!isLoadMore) {
          categoryProducts.clear();
        }
      }
    } catch (e) {
      printLog('Error loading category products: $e');
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
  }*/

  Future<void> getSupplierWiseProducts(
    int id,
    int page, {
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      isLoading.value = true;
      categoryProductsCurrentPage.value = page;
    } else {
      isPaginationLoading.value = true;
    }

    try {
      var response = await CategoryRepository().getSupplierWiseProduct(
        id,
        page,
      );

      if (response.data!.isNotEmpty) {
        categoryProductsTotalPage.value = response.total!;

        if (isLoadMore) {
          // Append new products to existing list
          categoryProducts.addAll(response.data ?? []);
        } else {
          // Replace existing products
          categoryProducts.clear();
          categoryProducts.addAll(response.data ?? []);
        }

        printLog('Supplier Products: ${categoryProducts.length}');
        printLog('Current Page: ${categoryProductsCurrentPage.value}');
        printLog('Total Pages: ${categoryProductsTotalPage.value}');
      } else {
        if (!isLoadMore) {
          categoryProducts.clear();
        }
      }
    } catch (e) {
      printLog('Error loading supplier products: $e');
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
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
    // getCategoryWiseProducts(id, 1);
  }
}
