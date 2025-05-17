import 'package:turi/app/data/remote/model/category/categorywiseproducts_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class CategoryRepository{
  Future<CategoryWiseProductsResponse> getCategoryWiseProduct(String
  categorySlug,
      String brandId)
  async {
    var response = await ApiClient().get(
      ApiEndPoints.categoryList(productCategory: categorySlug,brandId:brandId ),
      getCategoryWiseProduct,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return categoryWiseProductsResponseFromJson(response.toString());
  }

}