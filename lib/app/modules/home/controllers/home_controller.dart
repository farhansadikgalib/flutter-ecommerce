import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/home/brands_response.dart';
import 'package:turi/app/data/remote/model/home/category_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import 'package:turi/app/data/remote/repository/home/home_repository.dart';

class HomeController extends BaseController {
  final currentIndex = 0.obs;
  final cartCount = 0.obs;
  final imageList = <String>[].obs;
  final isLoading = true.obs;
  final isCategoryLoading = true.obs;
  final isBrandLoading = true.obs;
  final homeElements = <HomeData>[].obs;
  final categoriesData = <CategoriesData>[].obs;
  final brandsData = <BrandsData>[].obs;
  final Gallery3DController gallery3dController = Gallery3DController(
    itemCount: 5,
  );

  @override
  void onInit() {
    super.onInit();
    getHomeData();
    getCategoriesData();
    getBrandsData();
    ever(cartCount, (value) {
/*
      printLog("Cart count changed: $value");
*/
    });
  }

  getHomeData() async {
    var response = await HomeRepository().getHomeData();
    if (response.status == 200) {
      homeElements.add(response.data!);
      isLoading.value = false;
    } else {
      AppWidgets().getSnackBar(title: 'Error', message: response.message);
    }
  }

  getCategoriesData() async {
    var response = await HomeRepository().getCategoriesData();
    if (response.status == 200) {
      categoriesData.addAll(response.data!.data ?? []);
      isCategoryLoading.value = false;
    } else {
      AppWidgets().getSnackBar(title: 'Error', message: response.message);
    }
  }

  getBrandsData() async {
    var response = await HomeRepository().getBrandsData();
    if (response.status == 200) {
      brandsData.addAll(response.data!.data ?? []);
      isBrandLoading.value = false;
    } else {
      AppWidgets().getSnackBar(title: 'Error', message: response.message);
    }
  }
}
