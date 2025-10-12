import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';
import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/ecom_categories_response.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';
import '../../../data/remote/repository/home/home_repository.dart';

class CategoriesController extends BaseController {
  final ecomCategories = <EcomCategoriesResponse>[].obs;
  final selectedCategoryIndex = (-1).obs;

  final categoryWiseProducts = <ProductData>[].obs;
  final isCategoryProductsLoading = false.obs;

  // Pagination variables
  final categoryProductsTotalPage = 0.obs;
  final categoryProductsCurrentPage = 1.obs;
  final isPaginationLoading = false.obs;
  final ScrollController categoryProductsScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getEcomCategories();
    categoryProductsScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (categoryProductsScrollController.position.pixels >=
        categoryProductsScrollController.position.maxScrollExtent - 200) {
      if (!isPaginationLoading.value &&
          categoryProductsCurrentPage.value < categoryProductsTotalPage.value) {
        categoryProductsCurrentPage.value++;
        getCategoryWiseProduct(
          ecomCategories[selectedCategoryIndex.value].id.toString(),
          categoryProductsCurrentPage.value,
          isLoadMore: true,
        );
      }
    }
  }

  @override
  void onClose() {
    categoryProductsScrollController.removeListener(_onScroll);
    categoryProductsScrollController.dispose();
    super.onClose();
  }

  void getEcomCategories() async {
    var response = await HomeRepository().getEcomCategories();
    if (response.isNotEmpty) {
      ecomCategories.clear();
      ecomCategories.addAll(response);
      getCategoryWiseProduct(ecomCategories.first.id.toString(), 1);
      printLog('Ecom Categories: ${response.length}');
      // Auto-select first category if available
      if (response.isNotEmpty) {
        selectedCategoryIndex.value = 0;
      }
    }
  }

  Future<void> getCategoryWiseProduct(
    String categoryId,
    int page, {
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      isCategoryProductsLoading.value = true;
      categoryProductsCurrentPage.value = page;
    } else {
      isPaginationLoading.value = true;
    }

    try {
      var response = await HomeRepository().getCategoryWiseProduct(
        categoryId,
        page,
      );

      if (response.data!.isNotEmpty) {
        categoryProductsTotalPage.value = response.total!;

        if (isLoadMore) {
          // Append new products to existing list
          categoryWiseProducts.addAll(response.data ?? []);
        } else {
          // Replace existing products
          categoryWiseProducts.clear();
          categoryWiseProducts.addAll(response.data ?? []);
        }

        printLog('Category Wise Products: ${categoryWiseProducts.length}');
        printLog('Current Page: ${categoryProductsCurrentPage.value}');
        printLog('Total Pages: ${categoryProductsTotalPage.value}');
      } else {
        if (!isLoadMore) {
          categoryWiseProducts.clear();
        }
      }
    } catch (e) {
      printLog('Error loading category products: $e');
    } finally {
      isCategoryProductsLoading.value = false;
      isPaginationLoading.value = false;
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    if (index >= 0 && index < ecomCategories.length) {
      getCategoryWiseProduct(ecomCategories[index].id.toString(), 1);
    }

    printLog('Selected Category Index: $index');
  }

  // Load specific page
  Future<void> loadPage(int pageNumber) async {
    if (pageNumber < 1 || pageNumber > categoryProductsTotalPage.value) {
      return;
    }

    categoryProductsCurrentPage.value = pageNumber;
    await getCategoryWiseProduct(
      ecomCategories[selectedCategoryIndex.value].id.toString(),
      pageNumber,
    );
  }

  // Load next page
  Future<void> loadNextPage() async {
    if (categoryProductsCurrentPage.value < categoryProductsTotalPage.value) {
      categoryProductsCurrentPage.value++;
      await getCategoryWiseProduct(
        ecomCategories[selectedCategoryIndex.value].id.toString(),
        categoryProductsCurrentPage.value,
        isLoadMore: true,
      );
    }
  }

  // Load previous page
  Future<void> loadPreviousPage() async {
    if (categoryProductsCurrentPage.value > 1) {
      categoryProductsCurrentPage.value--;
      await getCategoryWiseProduct(
        ecomCategories[selectedCategoryIndex.value].id.toString(),
        categoryProductsCurrentPage.value,
      );
    }
  }

  // Load first page
  Future<void> loadFirstPage() async {
    categoryProductsCurrentPage.value = 1;
    await getCategoryWiseProduct(
      ecomCategories[selectedCategoryIndex.value].id.toString(),
      1,
    );
  }

  // Load last page
  Future<void> loadLastPage() async {
    categoryProductsCurrentPage.value = categoryProductsTotalPage.value;
    await getCategoryWiseProduct(
      ecomCategories[selectedCategoryIndex.value].id.toString(),
      categoryProductsTotalPage.value,
    );
  }

  // Refresh data
  Future<void> refreshData() async {
    categoryProductsCurrentPage.value = 1;
    await getCategoryWiseProduct(
      ecomCategories[selectedCategoryIndex.value].id.toString(),
      1,
    );
  }
}
