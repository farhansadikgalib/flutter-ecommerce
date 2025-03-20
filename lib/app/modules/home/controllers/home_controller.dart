import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/data/remote/model/home/category_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import 'package:turi/app/data/remote/repository/home/home_repository.dart';
import 'package:turi/generated/assets.dart';

class HomeController extends BaseController {
  final currentIndex = 0.obs;
  final imageList = <String>[].obs;
  final isLoading = true.obs;
  final isCategoryLoading = true.obs;
  final homeElements = <HomeData>[].obs;
  final categoriesData = <CategoriesData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getHomeData();
    getCategoriesData();
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
}
