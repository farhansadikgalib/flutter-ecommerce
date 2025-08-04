import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:turi/app/data/remote/model/home/brands_response.dart';
import 'package:turi/app/data/remote/model/home/category_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart' hide Product, Category;

import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class HomeRepository {
  Future<HomeResponse> getHomeData() async {
    var response = await ApiClient().get(
      ApiEndPoints.home,
      getHomeData,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return homeResponseFromJson(response.toString());
  }

  Future<List<CategoryData>> getCategoriesData() async {
    var response = await ApiClient().get(
      ApiEndPoints.categories,
      getCategoriesData,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryResponseFromJson(response.toString());
  }

  Future<BrandsResponse> getBrandsData() async {
    var response = await ApiClient().get(
      ApiEndPoints.brands,
      getBrandsData,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return brandsResponseFromJson(response.toString());
  }

  Future<List<ProductData>> getBestSellingProducts() async {
    var response = await ApiClient().get(
      ApiEndPoints.bestSellingProduct,
      getBestSellingProducts,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return bestSellingProductResponseFromJson(response.toString());
  }
}
