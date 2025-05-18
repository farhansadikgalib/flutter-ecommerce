import 'package:turi/app/data/remote/model/category/categorywiseproducts_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class CategoryRepository {
  Future<CategoryWiseProductsResponse> getCategoryWiseProduct(
    String categorySlug,
    String brandId,
    String shippingId,
      String minPrice,
      String maxPrice,
  ) async {
    var response = await ApiClient().get(
      ApiEndPoints.categoryList(
        productCategory: categorySlug,
        brandId: brandId,
        shippingId: shippingId, maxPrice: minPrice, minPrice: maxPrice,
      ),
      getCategoryWiseProduct,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryWiseProductsResponseFromJson(response.toString());
  }
}
