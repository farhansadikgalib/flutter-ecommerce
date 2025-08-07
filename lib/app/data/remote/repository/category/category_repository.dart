import 'package:turi/app/data/remote/model/category/categorywiseproducts_response.dart';
import 'package:turi/app/data/remote/model/search/search_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class CategoryRepository {
  Future<CategoryWiseProductsResponse> getCategoryWiseProduct(
    int categoryId,
  ) async {
    var response = await ApiClient().get(
      ApiEndPoints.categoryProductList(
        categoryId: categoryId,
      ),
      getCategoryWiseProduct,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryWiseProductsResponseFromJson(response.toString());
  }

  Future<CategoryWiseProductsResponse> getSupplierWiseProduct(
    int supplierId,
  ) async {
    var response = await ApiClient().get(
      ApiEndPoints.supplierProductList(
        categoryId: supplierId,
      ),
      getSupplierWiseProduct,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryWiseProductsResponseFromJson(response.toString());
  }

  Future<SearchResponse> getSearchItems(String query) async {
    var response = await ApiClient().get(
      ApiEndPoints.searchProduct(query: query),
      getSearchItems,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return searchResponseFromJson(response.toString());
  }
}
