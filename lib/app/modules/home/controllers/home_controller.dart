import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/home/supplier_response.dart';
import 'package:turi/app/data/remote/model/home/category_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart'
    hide Product, Category;
import 'package:turi/app/data/remote/repository/home/home_repository.dart';

import '../../../../generated/assets.dart';
import '../../../data/remote/model/category/ecom_categories_response.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';

class HomeController extends BaseController {
  final currentIndex = 0.obs;
  final imageList = <String>[].obs;
  final isLoading = true.obs;
  final isCategoryLoading = true.obs;
  final isSupplierLoading = true.obs;
  final homeElements = <HomeData>[].obs;
  final categoriesData = <CategoryData>[].obs;
  final supplierData = <SupplierResponse>[].obs;
  final bestSellingProducts = <ProductData>[].obs;
  final bannerImage = [Assets.pngB1, Assets.pngB2, Assets.pngB3].obs;
  final bestSellingTotalPage = 0.obs;
  final bestSellingCurrentPage = 1.obs;
  final isPaginationLoading = false.obs;
  final Gallery3DController gallery3dController = Gallery3DController(
    itemCount: 5,
  );

  final ScrollController bestSellingScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getCategoriesData();
    getSupplierData();
    getBestSellingProducts();
    bestSellingScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (bestSellingScrollController.position.pixels >= bestSellingScrollController.position.maxScrollExtent - 200) {
      if (!isPaginationLoading.value && bestSellingCurrentPage.value < bestSellingTotalPage.value) {
        bestSellingCurrentPage.value++;
        getBestSellingProducts(isLoadMore: true);
      }
    }
  }

  @override
  void onClose() {
    bestSellingScrollController.removeListener(_onScroll);
    bestSellingScrollController.dispose();
    super.onClose();
  }

  Future<void> getHomeData() async {
    var response = await HomeRepository().getHomeData();
    if (response.status == 200) {
      homeElements.clear();
      homeElements.add(response.data!);
      isLoading.value = false;
    } else {
      AppWidgets().getSnackBar(title: 'Error', message: response.message);
    }
  }

  Future<void> getCategoriesData() async {
    isCategoryLoading.value = true;
    var response = await HomeRepository().getCategoriesData();
    categoriesData.clear();
    categoriesData.addAll(response);
    isCategoryLoading.value = false;
  }

  Future<void> getSupplierData() async {
    isSupplierLoading.value = true;
    var response = await HomeRepository().getSupplierData();
    supplierData.clear();
    supplierData.addAll(response);
    isSupplierLoading.value = false;
  }

  Future<void> getBestSellingProducts({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      isLoading.value = true;
    } else {
      isPaginationLoading.value = true;
    }

    try {
      var response = await HomeRepository().getBestSellingProducts(
        bestSellingCurrentPage.value,
      );

      if (response.data!.isNotEmpty) {
        bestSellingTotalPage.value = response.total!;

        if (isLoadMore) {
          // Append new products to existing list
          bestSellingProducts.addAll(response.data ?? []);
        } else {
          // Replace existing products
          bestSellingProducts.clear();
          bestSellingProducts.addAll(response.data ?? []);
        }

        printLog('Best Selling Products: ${bestSellingProducts.length}');
        printLog('Current Page: ${bestSellingCurrentPage.value}');
        printLog('Total Pages: ${bestSellingTotalPage.value}');
      } else {
        if (!isLoadMore) {
          AppWidgets().getSnackBar(
            title: 'Error',
            message: 'No best selling products found',
          );
        }
      }
    } catch (e) {
      printLog('Error loading best selling products: $e');
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to load products',
      );
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
  }

  // Load specific page
  Future<void> loadPage(int pageNumber) async {
    if (pageNumber < 1 || pageNumber > bestSellingTotalPage.value) {
      return;
    }

    bestSellingCurrentPage.value = pageNumber;
    await getBestSellingProducts();
  }

  // Load next page
  Future<void> loadNextPage() async {
    if (bestSellingCurrentPage.value < bestSellingTotalPage.value) {
      bestSellingCurrentPage.value++;
      await getBestSellingProducts(isLoadMore: true);
    }
  }

  // Load previous page
  Future<void> loadPreviousPage() async {
    if (bestSellingCurrentPage.value > 1) {
      bestSellingCurrentPage.value--;
      await getBestSellingProducts();
    }
  }

  // Load first page
  Future<void> loadFirstPage() async {
    bestSellingCurrentPage.value = 1;
    await getBestSellingProducts();
  }

  // Load last page
  Future<void> loadLastPage() async {
    bestSellingCurrentPage.value = bestSellingTotalPage.value;
    await getBestSellingProducts();
  }

  // Refresh data
  Future<void> refreshData() async {
    bestSellingCurrentPage.value = 1;
    await getBestSellingProducts();
  }
}
