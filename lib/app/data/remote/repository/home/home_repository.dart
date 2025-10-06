import 'package:ousadbazar/app/data/remote/model/category/ecom_categories_response.dart';
import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:ousadbazar/app/data/remote/model/home/supplier_response.dart';
import 'package:ousadbazar/app/data/remote/model/home/category_response.dart';
import 'package:ousadbazar/app/data/remote/model/home/home_response.dart'
    hide Product, Category;

import '../../../../services/network_service/api_client.dart';
import '../../../../services/network_service/api_end_points.dart';

class HomeRepository {
  Future<HomeResponse> getHomeData() async {
    var response = await ApiClient().get(
      ApiEndPoints.home,
      getHomeData,
      isHeaderRequired: false,
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

  Future<List<SupplierResponse>> getSupplierData() async {
    var response = await ApiClient().get(
      ApiEndPoints.supplier,
      getSupplierData,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return supplierResponseFromJson(response.toString());
  }

  Future<BestSellingProductResponse> getBestSellingProducts(int page) async {
    var response = await ApiClient().get(
      ApiEndPoints.bestSellingProduct(page: page),
      getBestSellingProducts,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return bestSellingProductResponseFromJson(response.toString());
  }

  Future<List<EcomCategoriesResponse>> getEcomCategories() async {
    var response = await ApiClient().get(
      ApiEndPoints.ecomCategories,
      getEcomCategories,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return ecomCategoriesResponseFromJson(response.toString());
  }

  Future<BestSellingProductResponse> getCategoryWiseProduct(String
  categoryId,int page)
  async {
    var response = await ApiClient().get(
      ApiEndPoints.categoryWiseProduct(categoryId: categoryId.toString(), page: page),
      getBestSellingProducts,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return bestSellingProductResponseFromJson(response.toString());
  }
}
