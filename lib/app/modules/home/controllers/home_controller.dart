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
  final Gallery3DController gallery3dController = Gallery3DController(
    itemCount: 5,
  );

  @override
  void onInit() {
    super.onInit();
    // getHomeData();
    getCategoriesData();
    getSupplierData();
    getBestSellingProducts();
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

  Future<void> getBestSellingProducts() async {
    isLoading.value = true;
    var response = await HomeRepository().getBestSellingProducts();
    if (response.isNotEmpty) {
      bestSellingProducts.clear();
      bestSellingProducts.addAll(response);
      printLog('Best Selling Products: ${bestSellingProducts.length}');
      isLoading.value = false;
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'No best selling products found',
      );
    }
  }
}
